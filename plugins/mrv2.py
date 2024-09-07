"""
Handles installing Mrv2
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class Mrv2Installer(Plugin):
    """
    Mrv2
    """

    _alias_ = "Mrv2 Installer"
    # pylint:disable=line-too-long
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/mrv2.png?raw=true"
    description = "Sequence video player. Install Mrv2 to a target directory."
    category = "Applications"
    tags = [
        "mrv2",
        "viewer",
        "media",
        "vfx",
        "visual effects",
        "video",
        "sequences",
        "exr",
    ]
    fields = [
        Plugin.field("version", "Version of Mrv2 to install. Ex. 1.2.1", required=True),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    # pylint:disable=unused-argument
    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        # pylint:disable=attribute-defined-outside-init
        self.version = kwargs.get("version")
        self.download_url = kwargs.get(
            "url",
            "https://github.com/ggarra13/mrv2/releases/download/v1.2.1/mrv2-v1.2.1-Linux-amd64.tar.gz",
        )
        self.destination = Path(kwargs.get("destination")).as_posix()

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        os.makedirs(self.destination, exist_ok=True)

    # pylint:disable=unused-argument
    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the Mrv2.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/mrv2-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Mrv2")
