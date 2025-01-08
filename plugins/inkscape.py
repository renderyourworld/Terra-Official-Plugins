"""
Installer for Inkscape on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class InkscapeInstaller(Plugin):
    """
    Inkscape installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Inkscape Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/inkscape.png?raw=true"
    description = "A Free and open source vector graphics editor."
    category = "Applications"
    tags = ["Inkscape", "vector", "media", "graphics", "editor"]
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
            "https://inkscape.org/gallery/item/44616/Inkscape-091e20e-x86_64.AppImage",
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
                f"bash {scripts_directory}/inkscape-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Inkscape")

    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
