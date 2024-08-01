"""
Installer for Storyboard on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class StoryboardInstaller(Plugin):
    """
    Storyboard installer plugin.
    """

    _alias_ = "Storyboard Installer"
    icon = "https://appimage.github.io/database/storyboarder/icons/512x512/storyboarder.png"
    description = "Storyboarder makes it easy to visualize a story as fast you can draw stick figures."
    category = "Media and Entertainment"
    tags = ["Storyboard", "editor", "media", "editorial", "kde"]
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
            "https://github.com/wonderunit/storyboarder/releases/download/v3.0.0/Storyboarder-3.0.0-linux-x86_64.AppImage",
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
                f"bash {scripts_directory}/storyboard-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Storyboard")
