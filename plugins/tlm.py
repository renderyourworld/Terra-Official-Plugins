"""
Installer for tlm on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class TlmInstaller(Plugin):
    """
    Xnview installer plugin.
    """
    _alias_ = "Tlm Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/pack-additional-software/plugins/assets/tlm.png?raw=true"
    description = "Tool that mimics the permformance monitoring of windows task manager under linux"
    category = "Media and Entertainment"
    tags = ["Tlm", "editor", "media", "editorial", "kde"]
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
            "https://github.com/rejuce/LikeTaskManager/releases/download/v2.3/LikeTaskManager-x86_64.AppImage",
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
                    f"bash {scripts_directory}/tlm-installer.sh {self.download_url} {self.destination}",
                    shell=True,
                    check=False,
                ).returncode
                != 0
        ):
            raise RuntimeError("Failed to install Tlm")
