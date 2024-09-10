"""
Installer for Resolve on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class ResolveInstaller(Plugin):
    """
    Resolve installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Resolve Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/resolve.png?raw=true"
    description = "Resolve"
    category = "Applications"
    tags = ["resolve", "video", "editor", "timeline", "edit"]
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
            "https://swr.cloud.blackmagicdesign.com/DaVinciResolve/v18.6.6/DaVinci_Resolve_18.6.6_Linux.zip?verify=1723467358-f%2F4cqBSkZOIOnzqneYOYUaJOMAAEmMCWaz2RBrVsF%2BI%3D",
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
                f"bash {scripts_directory}/resolve-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Resolve")
