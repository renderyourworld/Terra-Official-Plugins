"""
Installer for steam on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class SteamInstaller(Plugin):
    """
    steam installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Steam Client"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/steam.png?raw=true"
    description = "Steam Client installer"
    category = "Games"
    tags = ["steam", "client", "games", "valve"]
    fields = []

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = "https://github.com/ddesmond/Steam-appimage/releases/download/continuous/Steam-1.0.0.81-2-3-x86_64.AppImage"
        self.destination = "/apps/steam"

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
                f"bash {scripts_directory}/steam-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install steam")
