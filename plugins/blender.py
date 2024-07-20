"""
Handles installing Blender
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class BlenderInstaller(Plugin):
    """
    Blender
    """

    _alias_ = "Blender Installer"
    icon = "https://download.blender.org/branding/community/blender_community_badge_white.png"
    description = "Blender is licensed as GNU GPL, owned by its contributors. For that reason Blender is Free and Open Source software, forever."
    category = "Media and Entertainment"
    tags = ["3d", "animation", "media", "vfx", "blender", "visual effects"]
    fields = [
        Plugin.field("version", "Version of Blender to install. i.e. 4.2.0", required=False),
        Plugin.field("destination", "Destination directory", required=True)
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.version = kwargs.get("version", "4.2.0")
        self.destination = kwargs.get("destination")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        if not self.destination.endswith("/"):
            self.destination += "/"

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the PyCharm.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if run(
                f"bash {scripts_directory}/blender-installer.sh {self.version} {self.destination}",
                shell=True
        ).returncode != 0:
            raise RuntimeError("Failed to install Blender")
