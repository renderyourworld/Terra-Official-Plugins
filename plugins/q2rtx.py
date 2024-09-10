"""
Installer for q2rtx on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class Q2rtxInstaller(Plugin):
    """
    q2rtx installer plugin.
    """
    _version_ = '1.0.0'
    _alias_ = "Q2rtx Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/q2rtx.png?raw=true"
    description = "Quake 2 RTX build from NVIDIA github repository."
    category = "Games"
    tags = ["q2rtx", "test", "benchmark", "rtx", "nvidia", "games"]
    fields = [
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = kwargs.get(
            "url",
            "https://github.com/NVIDIA/Q2RTX/releases/download/v1.7.0/q2rtx-1.7.0-linux.tar.gz",
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
                f"bash {scripts_directory}/q2rtx-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install q2rtx")
