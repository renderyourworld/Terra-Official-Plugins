"""
Juno's Pipeline Bundle
"""

# std
import os

# 3rd
from terra import Plugin
from terra.loaders import plugins


class JunoPipeline(Plugin):
    """
    Git Loader
    """
    _version_ = '1.0.0'
    _alias_ = "Juno Pipeline (Full)"
    icon = "https://avatars.githubusercontent.com/u/77702266?s=200&v=4"
    description = "Install the Juno Pipeline for 2D Visual Effects. Ships with Nuke, Blender, Houdini, and more."
    category = "Pipeline"
    tags = ["vfx", "pipeline", "juno", "2d", "visual effects"]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists
        """
        # if not os.path.exists("/pipe"):
        #     raise ValueError(
        #         "The pipeline directory does not exist. Please ensure the pipeline is mounted to /pipe."
        #     )

        # if not os.path.exists("/apps"):
        #     raise ValueError(
        #         "The apps directory does not exist. Please ensure the apps are mounted to /apps."
        #     )

    def install(self, *args, **kwargs) -> None:
        """
        Run git pull and install to the target directory
        """
        handler = plugins()
        handler.run_plugin(
            "plugin",
            "Pixelfudger v3.2",
            allow_failure=False,
            destination="/pipe/nuke/external/",
        )

        # handler.run_plugin(
        #     "plugin",
        #     "Kdenlive Installer",
        #     allow_failure=False,
        #     destination="/apps/kdenlive",
        # )
        #
        # handler.run_plugin(
        #     "plugin",
        #     "Blender Installer",
        #     allow_failure=False,
        #     destination="/apps/blender",
        #     version="4.2.0",
        # )
        #
        # handler.run_plugin(
        #     "plugin",
        #     "PyCharm Installer",
        #     allow_failure=False,
        #     destination="/apps/pycharm",
        #     version="2024.1.4",
        # )
        #
        # handler.run_plugin(
        #     "plugin", "ComfyUI Installer", allow_failure=False, destination="/apps/comfyui"
        # )
        #
        # handler.run_plugin(
        #     "plugin",
        #     "Nuke Installer",
        #     allow_failure=False,
        #     destination="/apps/nuke",
        #     version="Nuke15.1v1",
        # )
