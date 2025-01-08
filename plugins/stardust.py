"""
Cloning down a Stardust client from a Git Source to a target directory.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class StardustInstaller(Plugin):
    """
    Git Loader
    """

    _version_ = "1.0.0"
    _alias_ = "Stardust"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/stardust.png?raw=true"
    description = "Install Stardust Client"
    category = "Utility"
    tags = ["stardust", "client", "api", "workstation"]
    fields = [
        Plugin.field("pat", "Private Acces Token", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists
        """
        # store on instance
        self.destination = "/apps/stardust"
        self.pat = kwargs.get("pat")

    def install(self, *args, **kwargs) -> None:
        """
        Run git pull and install to the target directory
        """

        self.update_metadata({"install_location": self.destination})

        scripts_directory = os.path.abspath(f"{__file__}/../scripts")

        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/stardust-installer.sh {self.destination} {self.pat}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Stardust")

    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
