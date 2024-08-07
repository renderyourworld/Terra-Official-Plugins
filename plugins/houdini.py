"""
Handles installing Houdini by SideFX
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class HoudiniInstaller(Plugin):
    """
    Nuke
    """

    _alias_ = "Houdini Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/houdini.png?raw=true"
    description = "Install Houdini to a target directory."
    category = "Media and Entertainment"
    tags = ["houdini", "sidefx", "media", "vfx", "visual effects"]
    fields = [
        Plugin.field("version", "Version of Houdini to install. i.e. 20.5.278", required=True),
        Plugin.field("destination", "Destination directory", required=True),
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
        if (
                run(
                    f"bash {scripts_directory}/houdini-install.sh {self.version} {self.destination}",
                    shell=True,
                    check=False,
                ).returncode
                != 0
        ):
            raise RuntimeError("Failed to install Houdini")
