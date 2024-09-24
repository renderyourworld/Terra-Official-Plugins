"""
Installer for Silhouette2024 on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class Silhouette2024Installer(Plugin):
    """
    Kdenlive installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "Silhouette2024 Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/silhouette2024.png?raw=true"
    description = "Silhouette 2024 animation application, Full 4GB Install."
    category = "Applications"
    tags = [
        "silhouette",
        "roto",
        "media",
        "cg",
        "visual effects",
        "sequence",
        "animation",
    ]
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
            "https://cdn.borisfx.com/borisfx/store/silhouette/2024-0-1/Silhouette_2024_0_1_linux.tgz",
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
                f"bash {scripts_directory}/silhouette2024-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install silhouette2024")
