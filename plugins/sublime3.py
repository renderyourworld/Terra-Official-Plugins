"""
Handles installing Sublime3
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class Sublime3Installer(Plugin):
    """
    Sublime3
    """
    _version_ = '1.0.0'
    _alias_ = "Sublime3 Installer"
    # pylint: disable=line-too-long
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/sublime3.png?raw=true"
    description = "Install Sublime3 to a target directory."
    category = "Software Development"
    tags = ["Sublime3", "text", "editor", "code", "python"]
    fields = [
        Plugin.field(
            "version", "Version of Sublime3 to install. i.e. Sublime3", required=True
        ),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    # pylint: disable=unused-argument
    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        # pylint: disable=attribute-defined-outside-init
        self.version = kwargs.get("version")
        self.download_url = kwargs.get(
            "url",
            "https://download.sublimetext.com/sublime_text_3_build_3211_x64.tar.bz2",
        )
        self.destination = Path(kwargs.get("destination")).as_posix()


        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the Sublime3.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
                run(
                    f"bash {scripts_directory}/sublime3-installer.sh {self.download_url} {self.destination}",
                    # pylint: disable=line-too-long
                    shell=True,
                    check=False,
                ).returncode
                != 0
        ):
            raise RuntimeError("Failed to install Sublime3")
