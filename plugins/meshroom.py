"""
Installer for meshroom on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class MeshroomInstaller(Plugin):
    """
    Meshroom installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Meshroom Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/meshroom.png?raw=true"
    description = "Meshroom is a free, open-source 3D Reconstruction Software based on the AliceVision framework. Requires a CUDA-enabled GPU."
    category = "Applications"
    tags = [
        "meshroom",
        "geometry",
        "3d",
        "reconstruction",
        "photogrammetry",
        "tracking",
        "camera",
        "calibration",
        "alicevision",
    ]
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
        self.destination = Path(kwargs.get("destination")).as_posix()

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

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

    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
