"""
Installer for firefox on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class FirefoxInstaller(Plugin):
    """
    Firefox installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Firefox Browser"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/firefox.png?raw=true"
    description = "Firefox web browser installer. This plugin installs in the /apps/firefox directory as default."
    category = "Web"
    tags = ["firefox", "web", "browser"]
    fields = []

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        # firefox link is not from a rolling release
        self.download_url = "https://github.com/srevinsaju/Firefox-Appimage/releases/download/firefox-v129.0.r20240819150008/firefox-129.0.r20240819150008-x86_64.AppImage"
        self.destination = Path("/apps/firefox").as_posix()

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
                f"bash {scripts_directory}/firefox-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install firefox")
