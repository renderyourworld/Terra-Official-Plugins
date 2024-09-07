"""
Installer for imagemagick on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class ImagemagickInstaller(Plugin):
    """
    Imagemagick installer plugin.
    """

    _alias_ = "Imagemagick Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/imagemagick.png?raw=true"
    description = "Imagemagick installer"
    category = "Utility"
    tags = ["imagemagick", "cenverter", "graphics", "media"]
    fields = [
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url ="https://github.com/ImageMagick/ImageMagick/releases/download/7.1.1-36/ImageMagick-852a4e9-clang-x86_64.AppImage"
        self.destination = Path(kwargs.get("destination")).as_posix()


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
                f"bash {scripts_directory}/imagemagick-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install imagemagick")
