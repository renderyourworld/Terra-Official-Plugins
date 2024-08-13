"""
Handles installing Sublime3
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class Sublime3Installer(Plugin):
    """
    Sublime3
    """

    _alias_ = "Sublime3 Installer"
    # pylint: disable=line-too-long
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/sublime3.png?raw=true"
    description = "Install Sublime3 to a target directory."
    category = "Text editor"
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
        self.destination = kwargs.get("destination")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        if not self.destination.endswith("/"):
            self.destination += "/"

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the Sublime3.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
                run(
                    f"bash {scripts_directory}/Sublime3-installer.sh {self.version} {self.destination}",
                    # pylint: disable=line-too-long
                    shell=True,
                    check=False,
                ).returncode
                != 0
        ):
            raise RuntimeError("Failed to install Sublime3")
