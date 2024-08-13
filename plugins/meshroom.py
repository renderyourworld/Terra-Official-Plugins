"""
Installer for meshroom on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class MeshroomInstaller(Plugin):
    """
    Meshroom installer plugin.
    """

    _alias_ = "Meshroom Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/meshroom.png?raw=true"
    description = "Meshroom is a free, open-source 3D Reconstruction Software based on the AliceVision framework. Requires a CUDA-enabled GPU."
    category = "Media and Entertainment"
    tags = ["meshroom", "editor", "media", "reconstruction", "kde"]
    fields = [
        Plugin.field("url", "Download URL", required=False),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    # pylint: disable=unused-argument
    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        # pylint: disable=attribute-defined-outside-init
        self.download_url = kwargs.get(
            "url",
            "https://s3.eu-central-1.wasabisys.com/juno-deps/Meshroom-2023.3.0-linux.tar.gz",
        )
        self.destination = kwargs.get("destination")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        if not self.destination.endswith("/"):
            self.destination += "/"

        os.makedirs(self.destination, exist_ok=True)

    # pylint: disable=unused-argument
    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the PureRef.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")

        if (
                run(
                    f"bash {scripts_directory}/meshroom-installer.sh  {self.download_url}  {self.destination}",
                    shell=True,
                    check=False,
                ).returncode
                != 0
        ):
            raise RuntimeError("Failed to install meshroom")


