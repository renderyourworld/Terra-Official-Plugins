"""
Installer for blenderbenchmark on linux systems.
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin


class BlenderbenchmarkInstaller(Plugin):
    """
    Blenderbenchmark installer plugin.
    """

    _alias_ = "Blenderbenchmark Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/additional-pack/plugins/assets/blenderbenchmark.png?raw=true"
    description = "Blenderbenchmark is an acronym for KDE Non-Linear Video Editor. It works on GNU/Linux, Windows and BSD."
    category = "Media and Entertainment"
    tags = ["vfx", "editor", "media", "Blender", "benchmark", "kde"]
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
            "https://opendata.blender.org/cdn/BlenderBenchmark2.0/script/blender-benchmark-script-2.0.0.tar.gz",
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
                f"bash {scripts_directory}/blenderbenchmark-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Blenderbenchmark")
