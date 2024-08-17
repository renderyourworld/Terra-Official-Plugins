"""
Installer for Deadline10_repository on linux systems.
"""

# std
import os
import time
from subprocess import run

# 3rd
from terra import Plugin


class Deadline10_repositoryInstaller(Plugin):
    """
    deadline10_repository installer plugin.
    """

    _alias_ = "Deadline10_repository Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/deadline10repository.png?raw=true"
    description = "Deadline10_repository"
    category = "Rendering Management"
    tags = ["deadline10_repository", "editor", "media", "editorial", "kde"]
    fields = [
        Plugin.field("url", "Download URL", required=False),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = "https://thinkbox-installers.s3.us-west-2.amazonaws.com/Releases/Deadline/10.3/7_10.3.2.1/Deadline-10.3.2.1-linux-installers.tar"
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
        charts_directory = os.path.abspath(f"{__file__}/../charts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        # do helm install

        run(
            f"helm upgrade -i deadline10 {charts_directory}/deadline/  "
            f" --set start_service=false",
            shell=True
        )
        time.sleep(60)
        if (
            run(
                f"bash {scripts_directory}/deadline10_repository-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Deadline10_repository")
        if (
            run(
                f"bash {scripts_directory}/deadline10_client-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Deadline10_repository")
        #  helm star service to flase
        run(
            f"helm upgrade -i deadline10 {charts_directory}/deadline/  "
            f" --set start_service=true",
            shell=True
        )