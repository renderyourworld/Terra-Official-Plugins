"""
Installer for krita on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class KritaInstaller(Plugin):
    """
    Krita installer plugin.
    """

    _alias_ = "Krita Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/krita.png?raw=true"
    description = (
        "Krita is a sketching and painting program designed for digital artists. "
    )
    category = "Media and Entertainment"
    tags = ["graphics", "editor", "media", "photoshop", "paint", "krita", "kde"]
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
            "https://download.kde.org/stable/krita/5.2.3/krita-5.2.3-x86_64.appimage",
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
                f"bash {scripts_directory}/krita-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install krita")
