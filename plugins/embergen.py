"""
Installer for embergen on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class EmbergenInstaller(Plugin):
    """
    Embergen installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Embergen Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/embergen.png?raw=true"
    description = "Real-time Fire, Smoke, and Explosions"
    category = "Applications"
    tags = [
        "embergen",
        "simluation",
        "realtime",
        "fire",
        "cg",
        "vfx",
        "explosions",
        "smoke",
    ]
    fields = [
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = "https://jangafx-software-files.s3.amazonaws.com/embergen/installers/linux/embergen-1.2.1-linux.zip"
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
                f"bash {scripts_directory}/embergen-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install embergen")
