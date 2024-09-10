"""
Installer for Deadline10 on linux systems.
"""

# std
import os
import time
from subprocess import run
import pathlib

# 3rd
from terra import Plugin


class Deadline10Installer(Plugin):
    """
    Deadline10 repository, client and webservice installer plugin.
    """
    _version_ = "1.1.0"
    _alias_ = "Deadline10 Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/deadline10repository.png?raw=true"
    description = "Deadline 10.3.2.1. The plugin will install the repository, client and web service. Long install times expected."
    category = "Rendering Management"
    tags = ["deadline10_repository", "editor", "media", "editorial", "kde"]
    fields = [
        Plugin.field("url", "Download URL", required=False),
        Plugin.field("install_volume", "The name of the install volume", required=True),
        Plugin.field("database_volume", "The name of the database volume", required=True),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = "https://thinkbox-installers.s3.us-west-2.amazonaws.com/Releases/Deadline/10.3/7_10.3.2.1/Deadline-10.3.2.1-linux-installers.tar"
        self.destination = kwargs.get("destination")
        self.install_volume = kwargs.get("install_volume")
        self.database_volume = kwargs.get("database_volume")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        if not self.destination.endswith("/"):
            self.destination += "/"

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the appimage to the destination directory.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        charts_directory = os.path.abspath(f"{__file__}/../charts")
        self.logger.info(f"Loading scripts from {scripts_directory}")

        # setup files
        run(
            f"bash {scripts_directory}/deadline_setup_files.sh {charts_directory}/deadline/templates/configmap.yaml {pathlib.Path(self.destination).as_posix()}",
            shell=True
        )

        # do helm install
        run(
            f"helm upgrade -i deadline10 {charts_directory}/deadline/  "
            f" --set start_service=false --set claim_name={self.install_volume} --set claim_name_mongo={self.database_volume}"
            f" --set destination={pathlib.Path(self.destination).as_posix()}",
            shell=True
        )

        # wait to settle
        time.sleep(45)

        # download deadline10
        if (
            run(
                f"bash {scripts_directory}/deadline10_downloader.sh {self.download_url} {self.destination}",
                shell=True,
                check=False
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to downloade Deadline10 installer")
        time.sleep(15)
        # install deadline10 repository
        if (
            run(
                f"bash {scripts_directory}/deadline10_repository-installer.sh {self.download_url} {pathlib.Path(self.destination).as_posix()}",
                shell=True,
                check=False
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Deadline10 repository")

        time.sleep(15)
        if (
            run(
                f"bash {scripts_directory}/deadline10_client-installer.sh {self.download_url} {pathlib.Path(self.destination).as_posix()}",
                shell=True,
                check=False
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Deadline10 client")

        time.sleep(15)
        #  helm star service to flase
        run(
            f"helm upgrade -i deadline10 {charts_directory}/deadline/  "
            f" --set start_service=true --set claim_name={self.install_volume} --set claim_name_mongo={self.database_volume}"
            f" --set destination={pathlib.Path(self.destination).as_posix()}",
            shell=True
        )

        # wait to settle
        time.sleep(90)



