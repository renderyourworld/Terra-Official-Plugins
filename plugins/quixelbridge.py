"""
Installer for QuixelBridge on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class QuixelBridgeInstaller(Plugin):
    """
    QuixelBridge installer plugin.
    """

    _alias_ = "QuixelBridge Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/pack-additional-software/plugins/assets/quixel_bridge.png?raw=true"
    description = "Browse the libraries of Megascans and MetaHumans content in a quick and artist-friendly way through Bridge."
    category = "Media and Entertainment"
    tags = ["bridge", "editor", "media", "textures", "cg"]
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
            "https://d2shgxa8i058x8.cloudfront.net/bridge/linux/Bridge.AppImage",
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
                f"bash {scripts_directory}/quixelbridge-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install QuixelBridge")
