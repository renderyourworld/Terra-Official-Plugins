"""
Installer for alab on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class AlabInstaller(Plugin):
    """
    Alab installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Alab Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/alab.png?raw=true"
    description = "Alab sample USD files, big download. Long install time."
    category = "Samples"
    tags = ["alab", "samples", "files", "cg", "3d", "usd"]
    fields = []
    executable = "/apps/alab/alab.sh"

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = "alab"
        self.destination = "/apps/alab"

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the appimage to the destination directory.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/alab-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install alab")
