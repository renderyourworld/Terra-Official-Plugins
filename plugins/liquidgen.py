"""
Installer for liquidgen on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class LiquidGenInstaller(Plugin):
    """
    liquidgen installer plugin.
    """

    _alias_ = "LiquidGen Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/liquidgen.png?raw=true"
    description = "LiquiGen allows you to create anything from water and blood to ketchup and slime."
    category = "Media and Entertainment"
    tags = ["liquidgen", "editor", "media", "editorial", "kde"]
    fields = [
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = "https://jangafx-software-files.s3.amazonaws.com/liquigen/installers/linux/liquigen-0.3.0-alpha-linux.zip"
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
                f"bash {scripts_directory}/liquidgen-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install liquidgen")
