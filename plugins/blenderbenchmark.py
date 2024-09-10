"""
Installer for blenderbenchmark on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class BlenderbenchmarkInstaller(Plugin):
    """
    Blenderbenchmark installer plugin.
    """
    _version_ = '1.0.0'
    _alias_ = "Blender Benchmark"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/blenderbenchmark.png?raw=true"
    description = "Blender benchmark your system. Requires Blender to be installed."
    category = "Benchmark"
    tags = ["vfx", "3d", "blender", "benchmark"]
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
                f"bash {scripts_directory}/blenderbenchmark-installer.sh {self.download_url} {self.destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Blenderbenchmark")
