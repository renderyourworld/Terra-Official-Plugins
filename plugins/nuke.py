"""
Handles installing Nuke by the Foundry
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class NukeInstaller(Plugin):
    """
    Nuke
    """

    _alias_ = "Nuke Installer"
    icon = "https://www.foundry.com/sites/default/files/2021-03/ICON_NUKE-rgb-yellow-01.png"
    description = "Install The Foundry's Nuke to a target directory."
    category = "Media and Entertainment"
    tags = ["nuke", "foundry", "media", "vfx", "visual effects"]
    fields = [
        Plugin.field("version", "Version of Nuke to install. i.e. Nuke14.0v2", required=True),
        Plugin.field("destination", "Destination directory", required=True)
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.version = kwargs.get("version")
        self.destination = kwargs.get("destination")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        if not self.destination.endswith("/"):
            self.destination += "/"

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the Nuke.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if run(
                f"bash {scripts_directory}/nuke-installer.sh {self.version} {self.destination}",
                shell=True
        ).returncode != 0:
            raise RuntimeError("Failed to install Nuke")
