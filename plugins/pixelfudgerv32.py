"""
Pixelfudger v3.2
"""

# std
import os
from subprocess import run

# 3rd
from terra import Plugin
from terra.loaders import plugins


class Pixelfudger_v32(Plugin):
    """
    Git Pixelfudger v3.2
    """

    _version_ = "1.0.0"
    _alias_ = "Pixelfudger v3.2"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/pixelfudger.png?raw=true"
    description = "Famous Nuke Gizmos and Tools. http://www.pixelfudger.com/"
    category = "Plugin"
    tags = [
        "vfx",
        "pipeline",
        "pixelfudger",
        "visual effects",
        "nuke",
        "plugin",
        "gizmos",
    ]

    def install(self, *args, **kwargs) -> None:
        """
        Run git pull and install to the target directory
        """
        destination = kwargs.get("destination")
        os.makedirs(destination, exist_ok=True)

        handler = plugins()
        handler.run_plugin(
            "plugin",
            "Downloader",
            allow_failure=False,
            url="http://www.pixelfudger.com/downloads/pixelfudger_3.2v1_nov_2023.zip",
            destination=destination,
        )

        for download in os.listdir(destination):
            if download.endswith(".zip"):
                run(
                    f"unzip {destination}/{download} -d {destination}",
                    shell=True,
                    check=True,
                )
                os.remove(f"{destination}/{download}")
                break
