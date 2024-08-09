"""
Installer for threedeelight on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class ThreedelightInstaller(Plugin):
    """
    threedelight installer plugin.
    """

    _alias_ = "Threedelight Installer"
    icon = "https://www.3delight.com/static/media/3delight_white_2k.8d2b2410.png"
    description = "Refreshingly Simple and Fast rendering engine."
    category = "Media and Entertainment"
    tags = ["3delight", "editor", "media", "editorial", "vfx"]
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
            "https://s3.eu-central-1.wasabisys.com/juno-deps/3DelightNSI-2.9.104-Linux-x86_64.tar.xz",
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
                f"bash {scripts_directory}/threedelight-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install threedelight")
