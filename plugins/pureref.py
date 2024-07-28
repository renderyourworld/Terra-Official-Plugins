"""
Handles installing PureRef
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class PureRefInstaller(Plugin):
    """
    PureRef
    """

    _alias_ = "PureRef Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/pureref.png?raw=true"
    description = "Install PureRef to a target directory."
    category = "Media and Entertainment"
    tags = ["PureRef", "references", "media", "vfx", "visual effects", "images"]
    fields = [
        Plugin.field("version", "Version of PureRef to install. i.e. PureRef Latest", required=True),
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
        Download and unpack the PureRef.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
                run(
                    f"bash {scripts_directory}/PureRef-installer.sh {self.version} {self.destination}",
                    shell=True,
                    check=False,
                ).returncode
                != 0
        ):
            raise RuntimeError("Failed to install PureRef")
