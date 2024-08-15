"""
Installer for Deadline10_service on linux systems.
"""

# std
import os
from subprocess import run
import time
# 3rd
from terra import Plugin


class Deadline10_serviceInstaller(Plugin):
    """
    Deadline10_service installer plugin.
    """

    _alias_ = "Deadline10_service Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/deadline10service.png?raw=true"
    description = "Deadline10.3 Webservice"
    category = "REnder Managment"
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

        # assert os.path.exists("/apps/deadline10/repository/")
        # assert os.path.exists("/apps/deadline10/client/")

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the appimage to the destination directory.
        """
        charts_directory = os.path.abspath(f"{__file__}/../charts")
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        self.logger.info("Installing Service to Terra")

        self.logger.info(f"{self.destination} Service installed.")
        #
        # run(
        #     f"helm upgrade -i deadline10 {charts_directory}/deadline/  "
        #     f" --set start_service=false",
        #     shell=True
        # )
        # time.sleep(60)
        #
        # #  helm star service to flase
        # run(
        #     f"helm upgrade -i deadline10 {charts_directory}/deadline/  "
        #     f" --set start_service=true",
        #     shell=True
        # )
        #
        # print("Setup Service done")