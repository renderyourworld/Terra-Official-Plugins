"""
Installer for Resolve on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class ResolveInstaller(Plugin):
    """
    Resolve installer plugin.
    """

    _version_ = "1.0.1"
    _alias_ = "Resolve Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/resolve.png?raw=true"
    description = "DaVinci Resolve for Linux is a free download and does not require a license dongle or an activation."
    category = "Applications"
    tags = ["resolve", "video", "editor", "timeline", "edit"]
    fields = [
        Plugin.field("version_to_install", "Version to install, 18 or 19", required=True),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.destination = Path(kwargs.get("destination")).as_posix()
        self.version_to_install = str(kwargs.get("version_to_install"))

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")
        # validate
        if not self.version_to_install:
            raise ValueError("No supported version provided")

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the appimage to the destination directory.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/resolve-installer.sh {self.destination} {self.version_to_install}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Resolve")
