"""
Handles installing Blender
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class BlenderInstaller(Plugin):
    """
    Blender
    """

    _version_ = "1.0.0"
    _alias_ = "Blender Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/blender.png?raw=true"
    description = "Blender is licensed as GNU GPL, owned by its contributors. For that reason Blender is Free and Open Source software, forever."
    category = "Applications"
    tags = [
        "3d",
        "animation",
        "vfx",
        "blender",
        "visual effects",
        "3d",
        "cg",
        "modeling",
    ]
    fields = [
        Plugin.field(
            "version", "Version of Blender to install. i.e. 4.2.0", required=False
        ),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.version = kwargs.get("version", "4.2.0")
        self.destination = Path(kwargs.get("destination")).as_posix()

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the PyCharm.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/blender-installer.sh {self.version} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Blender")
