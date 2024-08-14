"""
Installer for Deadline10_client on linux systems.
"""

# std
import os
from subprocess import run
import time
# 3rd
from terra import Plugin


class Deadline10_clientInstaller(Plugin):
    """
    Deadline10_client installer plugin.
    """

    _alias_ = "Deadline10_client Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/deadline10client.png?raw=true"
    description = "Deadline 10.3 client installer for linux systems."
    category = "Rendering Management"
    tags = ["deadline", "rendering", "client", "render"]
    fields = [
        Plugin.field("url", "Download URL", required=False),
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
        run(
            f"helm upgrade -i deadline10 {charts_directory}/deadline/  "
            f" --set start_service=false",
            shell=True
        )
        time.sleep(60)
        if (
            run(
                f"bash {scripts_directory}/deadline10_client-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Deadline10_client")
        #  helm star service to flase
        run(
            f"helm upgrade -i deadline10 {charts_directory}/deadline/  "
            f" --set start_service=true",
            shell=True
        )