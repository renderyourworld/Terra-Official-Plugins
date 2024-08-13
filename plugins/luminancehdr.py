"""
Installer for luminancehdr on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class LuminancehdrInstaller(Plugin):
    """
    Kdenlive installer plugin.
    """

    _alias_ = "Luminancehdr Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/luminancehdr.png?raw=true"
    description = "Luminance HDR is an application for taking a set of pictures of the same scene with different exposure settings and creating a high dynamic range"
    category = "Media and Entertainment"
    tags = ["luminancehdr", "editor", "cg", "hdr", "vfx"]
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
            "https://github.com/aferrero2707/lhdr-appimage/releases/download/continuous/luminance-hdr-git-20200421_1638.glibc2.17-x86_64.AppImage",
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
                f"bash {scripts_directory}/luminancehdr-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install luminancehdr")
