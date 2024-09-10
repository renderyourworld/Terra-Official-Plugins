"""
Installer for gaffer on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class GafferInstaller(Plugin):
    """
    Gaffer installer plugin.
    """
    _version_ = '1.0.0'
    _alias_ = "Gaffer Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/gaffer.png?raw=true"
    description = "Gaffer is a VFX application that enables artists to easily build, tweak, iterate, and render scenes."
    category = "Applications"
    tags = ["gaffer", "editor", "rendering", "vfx", "cg", "3d", "visual effects"]
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
            "https://github.com/GafferHQ/gaffer/releases/download/1.4.11.0/gaffer-1.4.11.0-linux-gcc9.tar.gz",
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
                f"bash {scripts_directory}/gaffer-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Gaffer")
