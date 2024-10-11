"""
Installer for handbrake on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class HandbrakeInstaller(Plugin):
    """
    Handbrake installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Handbrake Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/handbrake.png?raw=true"
    description = "Hanbrake video converter"
    category = "Utility"
    tags = [
        "handbrake",
        "convert",
        "media",
        "video",
        "sequences",
        "encoding",
        "transcoding",
        "decoding",
    ]
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
            # "https://github.com/ivan-hc/Handbrake-appimage/releases/download/continuous/HandBrake_1.8.2-1-archimage3.4-x86_64.AppImage",
            "https://github.com/ddesmond/Handbrake-appimage/releases/download/continuous/HandBrake_1.8.2-1-archimage3.4-x86_64.AppImage",
        )
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
                f"bash {scripts_directory}/handbrake-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install handbrake")
