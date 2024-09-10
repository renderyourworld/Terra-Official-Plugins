"""
Installer for imagestacker on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class ImagestackerInstaller(Plugin):
    """
    Imagestacker installer plugin.
    """
    _version_ = '1.0.0'
    _alias_ = "Imagestacker Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/imagestacker.png?raw=true"
    description = "Automatically generate layered PSD/PSB Files from CG Renders with OCIO support and Cryptomatte decoding"
    category = "Utility"
    tags = ["imagestacker", "psd", "layer", "stack", "cli", "photoshop"]
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
            "https://emildohne.com/wp-content/uploads/ImageStacker_1.0.0_Linux_x86.zip",
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
                f"bash {scripts_directory}/imagestacker-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install imagestacker")
