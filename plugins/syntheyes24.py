"""
Installer for syntheyes24 on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class Syntheyes24Installer(Plugin):
    """
    Kdenlive installer plugin.
    """

    _alias_ = "Syntheyes24 Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/syntheyes24.png?raw=true"
    description = "Syntheyes24 3d tracking software"
    category = "Applications"
    tags = ["syntheyes", "tracking", "media", "3d", "cg", "visual effects", "sequence", "camera"]
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
            "https://cdn.borisfx.com/borisfx/store/sy/SynLnx2406b1062_20240805a.tar.gz",
        )
        self.destination = kwargs.get("destination")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        if self.destination.endswith("/"):
            self.destination = self.destination[:-1]

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the appimage to the destination directory.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/syntheyes24-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Syntheyes24")
