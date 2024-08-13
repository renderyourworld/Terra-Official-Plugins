"""
Installer for flameshot on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class FlameshotInstaller(Plugin):
    """
    Flameshot installer plugin.
    """

    _alias_ = "Flameshot Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/flameshot.png?raw=true"
    description = "Powerful, yet simple to use open-source screenshot software."
    category = "Media and Entertainment"
    tags = ["flameshot", "editor", "media", "editorial", "screenshot"]
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
            "https://github.com/flameshot-org/flameshot/releases/download/v12.1.0/Flameshot-12.1.0.x86_64.AppImage",
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
                f"bash {scripts_directory}/flameshot-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install flameshot")
