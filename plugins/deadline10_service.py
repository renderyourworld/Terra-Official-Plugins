"""
Installer for Deadline10_service on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class Deadline10_serviceInstaller(Plugin):
    """
    Deadline10_service installer plugin.
    """

    _alias_ = "Deadline10_service Installer"
    icon = "https://kdenlive.org/wp-content/uploads/2022/01/kdenlive-logo-blank-500px.png"
    description = "Deadline10.3 Webservice"
    category = "Media and Entertainment"
    tags = ["deadline", "service", "repository", "aws", "submission", "rendering"]
    fields = [
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = None
        self.destination = kwargs.get("destination")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        if not self.destination.endswith("/"):
            self.destination += "/"

        assert os.path.exists("/apps/deadline10/repository/")
        assert os.path.exists("/apps/deadline10/client/")

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the appimage to the destination directory.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        self.logger.info("Installing Service to Terra")

        self.logger.info(f"{self.destination} Service installed.")

