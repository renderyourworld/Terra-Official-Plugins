"""
Installer for ldpk on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class ldpkInstaller(Plugin):
    """
    Ldpk installer plugin.
    """

    _version_ = "1.0.0"
    _alias_ = "ldpk Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/ldpk.png?raw=true"
    description = "The Lens Distortion Plugin Kit (LDPK) toolkit to help develop lens distortion plugins for 3DE4 and compositing systems."
    category = "Media and Entertainment"
    tags = ["ldpk", "editor", "media", "editorial", "kde"]
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
            "https://www.3dequalizer.com/user_daten/sections/tech_docs/archives/ldpk-2.12.0.tgz",
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
                f"bash {scripts_directory}/ldpk-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install ldpk")
