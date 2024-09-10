"""
Handles installing ComfyUI
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class ComfyUIInstaller(Plugin):
    """
    ComfyUI
    """

    _version_ = "1.0.0"
    _alias_ = "ComfyUI Installer"
    icon = "https://avatars.githubusercontent.com/u/121283862?v=4"
    description = "The most powerful and modular stable diffusion GUI, api and backend with a graph/nodes interface."
    category = "Media and Entertainment"
    tags = [
        "ai",
        "stable diffusion",
        "media",
        "vfx",
        "visual effects",
        "comfyui",
        "generative ai",
        "gen ai",
    ]
    fields = [Plugin.field("destination", "Destination directory", required=True)]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.destination = Path(kwargs.get("destination")).as_posix()

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the ComfyUI.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/comfyui-installer.sh {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install ComfyUI")
