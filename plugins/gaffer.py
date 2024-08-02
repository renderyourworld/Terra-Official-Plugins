"""
Installer for gaffer on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class GafferInstaller(Plugin):
    """
    Gaffer installer plugin.
    """

    _alias_ = "Gaffer Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/pack-additional-software/plugins/assets/gaffer.png?raw=true"
    description = "Gaffer is a VFX application that enables artists to easily build, tweak, iterate, and render scenes."
    category = "Media and Entertainment"
    tags = ["gaffer", "editor", "media", "vfx", "kde"]
    fields = [
        Plugin.field("url", "Download URL", required=False),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = kwargs.get(
            "url",
            "https://github.com/GafferHQ/gaffer/releases/download/1.4.10.0/gaffer-1.4.10.0-linux-gcc9.tar.gz",
        )
        self.destination = kwargs.get("destination")

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
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/gaffer-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Gaffer")
