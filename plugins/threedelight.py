"""
Installer for threedelight on linux systems.
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
    _version_ = '1.0.0'
    _alias_ = "Threedelight Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/threedelight.png?raw=true"
    description = "Refreshingly Simple and Fast rendering engine."
    category = "Plugin"
    tags = ["3delight", "rendering", "plugin", "3d", "vfx", "visual effects", "light", "camera"]
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
            "https://3delight-downloads.s3-us-east-2.amazonaws.com/free/release/2024-08-05-TPhetmWH/3DelightNSI-2.9.105-Linux-x86_64.tar.xz",
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
