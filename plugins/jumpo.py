"""
Installer for jumpo on linux systems.
"""

# std
import os
import time
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class JumpoInstaller(Plugin):
    """
    jumpo installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Jumpo Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/jumpo.png?raw=true"
    description = "SSH Jump Box Plugin"
    category = "Media and Entertainment"
    tags = ["jumpo", "ssh", "utlities", "shell"]
    fields = [
        Plugin.field("ssh_key", "SSH Key", required=True),
        Plugin.field("ssh_port", "SSH Key", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.ssh_key = kwargs.get("ssh_key")
        self.ssh_port = kwargs.get("ssh_port")

        # validate
        if not self.ssh_key:
            raise ValueError("No ssh_key provided")

        if not self.ssh_port:
            raise ValueError("No ssh_port provided")

    def install(self, *args, **kwargs) -> None:
        """
        Setup jumpo on the target system.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        charts_directory = os.path.abspath(f"{__file__}/../charts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        self.logger.info(f"Loading charts from {charts_directory}")
        print(self.ssh_key)

        self.ssh_key_file = Path("/tmp/key.txt").as_posix()
        with open(self.ssh_key_file, "w") as file:
            file.write(self.ssh_key)
        time.sleep(5)

        # setup jumpo files
        if (
            run(
                f"bash {scripts_directory}/jumpo-installer.sh {charts_directory}/jumpo/templates/configmap.yaml {self.ssh_key_file}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Jumpo")
        time.sleep(10)

        # # do helm install
        run(
            f"helm upgrade -i jumposervice {charts_directory}/jumpo/  "
            f" --set start_service=false "
            f" --set ssh_key={self.ssh_key_file} "
            f" --set ssh_port={self.ssh_port}",
            shell=True,
        )
        #
        # # wait to settle
        time.sleep(30)
        #
        #
        #
        # #  helm star service to flase
        run(
            f"helm upgrade -i jumposervice {charts_directory}/jumpo/  "
            f" --set start_service=true "
            f" --set ssh_key={self.ssh_key_file}"
            f" --set ssh_port={self.ssh_port}",
            shell=True,
        )
        # time.sleep(45)
        #

        time.sleep(600)

    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
