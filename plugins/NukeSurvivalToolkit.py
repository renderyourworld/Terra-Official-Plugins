"""
Nuke Survival Toolkit v2.1.1
"""

# std
import os
import shutil
from subprocess import run

# 3rd
from terra import Plugin
from terra.loaders import plugins


class NukeSurvivalToolkit_v211(Plugin):
    """
    Git Nuke Survival Toolkit v2.1.1
    """

    _alias_ = "Nuke Survival Toolkit v2.1.1"
    icon = "https://user-images.githubusercontent.com/46404545/93950690-76be2e00-fd44-11ea-96a6-07070b28df81.jpg"
    description = "The Nuke Survival Toolkit is a portable tool menu for the Foundry’s Nuke with a hand-picked selection of nuke gizmos collected from all over the web, organized into 1 easy to install toolbar."
    category = "Media and Entertainment"
    tags = ["vfx", "pipeline", "nuke survival toolkit", "visual effects"]

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
            url="https://codeload.github.com/CreativeLyons/NukeSurvivalToolkit_publicRelease/zip/refs/tags/v2.1.1",
            destination=destination,
        )

        run(f"unzip {destination}/v2.1.1 -d {destination}", shell=True, check=True)
        shutil.move(f"{destination}/NukeSurvivalToolkit_publicRelease-2.1.1/NukeSurvivalToolkit", f"{destination}/")
        os.unlink(f"{destination}/v2.1.1")
        shutil.rmtree(f"{destination}/NukeSurvivalToolkit_publicRelease-2.1.1")
