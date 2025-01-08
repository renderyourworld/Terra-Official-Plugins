"""
Installer for libreoffice on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class LibreofficeInstaller(Plugin):
    """
    Kdenlive installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Libreoffice Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/libreoffice.png?raw=true"
    description = (
        "LibreOffice is a free and powerful office suite, and a successor to OpenOffice.org"
    )
    category = "Office"
    tags = ["libreoffice", "editor", "media", "editorial", "kde"]
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
            "https://appimages.libreitalia.org/LibreOffice-fresh.standard-x86_64.AppImage",
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
                f"bash {scripts_directory}/libreoffice-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install libreoffice")

    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
