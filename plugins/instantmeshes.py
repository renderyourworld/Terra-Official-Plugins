"""
Installer for Instantmeshes on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path
# 3rd
from terra import Plugin


class InstantmeshesInstaller(Plugin):
    """
    instantmeshes installer plugin.
    """

    _alias_ = "Instantmeshes Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/instantmeshes.png?raw=true"
    description = "Instant Field-Aligned Meshes - remeshing tool."
    category = "Media and Entertainment"
    tags = ["instantmeshes", "editor", "media", "vfx", "geometry", "mesh", "remesh", "3d"]
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
            "https://instant-meshes.s3.eu-central-1.amazonaws.com/instant-meshes-linux.zip",
        )
        self.destination = Path(kwargs.get("destination")).as_posix()

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the appimage to the destination directory.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/instantmeshes-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install instantmeshes")
