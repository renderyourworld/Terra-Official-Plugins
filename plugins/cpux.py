"""
Installer for CpuX on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path
# 3rd
from terra import Plugin


class CpuXInstaller(Plugin):
    """
    CpuX installer plugin.
    """
    _alias_ = "CpuX Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/cpux.png?raw=true"
    description = "CPU-X is a software that gathers information on CPU, motherboard and more."
    category = "Utility"
    tags = ["cpux", "stats", "system", "utilities"]
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
            "https://github.com/TheTumultuousUnicornOfDarkness/CPU-X/releases/download/v5.0.4/CPU-X-5.0.4-x86_64.AppImage",
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
                    f"bash {scripts_directory}/cpux-installer.sh {self.download_url} {self.destination}",
                    shell=True,
                    check=False,
                ).returncode
                != 0
        ):
            raise RuntimeError("Failed to install Cpux")
