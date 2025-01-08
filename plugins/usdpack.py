"""
Installer for usd pack on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class UsdPackInstaller(Plugin):
    """
    UsdPack installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "UsdPack Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/usdview.png?raw=true"
    description = "NVIDIA Compiled USD binaries for Linux"
    category = "Applications"
    tags = [
        "usd",
        "usdview",
        "samples",
        "visual effect",
        "vfx",
        "python",
        "3d",
        "cg",
        "animation",
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
            "https://developer.download.nvidia.com/USD/usd_binaries/24.05/usd.py310.linux-x86_64.usdview.release@0.24.05-tc.859+release.2864f3d0.zip?t=eyJscyI6ImdzZW8iLCJsc2QiOiJodHRwczovL3d3dy5nb29nbGUuY29tLyJ9",
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
                f"bash {scripts_directory}/usdpack-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Usd")

    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
