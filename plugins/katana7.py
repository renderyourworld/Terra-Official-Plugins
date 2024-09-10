"""
Installer for Katana7 on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class Katana7Installer(Plugin):
    """
    Katana7 installer plugin.
    """
    _version_ = '1.0.0'
    _alias_ = "Katana7 Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/katana.png?raw=true"
    description = "Katana's advanced lighting animation software with powerful rendering tools delivers seamless and collaborative edits to 3D lighting effects."
    category = "Applications"
    tags = ["katana", "vfx", "lightning", "cg", "render", "rendering", "3d", "animation", "lightning", "visual effects"]
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
            "https://www.foundry.com/products/download_product?file=Katana7.0v3-linux-x86-release-64.tgz",
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
                f"bash {scripts_directory}/katana7-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Katana7")
