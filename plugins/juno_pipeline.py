"""
Juno's Pipeline Bundle
"""

# std
import os
from requests import request

# 3rd
from terra import Plugin
from terra.loaders import plugins


class JunoPipeline(Plugin):
    """
    Git Loader
    """

    _version_ = "1.0.0"
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

        delivery_task = {"code": "DeliveryTemplate", "parent": None, "type": 1040}
        luna_url = "http://luna:8000/"
        meta_url = f"{luna_url}/meta"

        response = self.get_task(url=meta_url, task=delivery_task)
        status_code = response.status_code
        if status_code == 200 and not response.json():
            response = self.create_task(url=meta_url, task=delivery_task)
        print(response.status_code)

        # handler = plugins()
        # handler.run_plugin(
        #     "plugin",
        #     "Pixelfudger v3.2",
        #     allow_failure=False,
        #     destination="/pipe/nuke/external/",
        # )

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

    def get_task(self, url, task):
        """
        get a task from luna
        """
        url = f"{url}/filter"
        response = request("post", url, json=task)
        return response

    def create_task(self, url, task):
        """
        create a task in luna
        """
        task['metadata'] = {'TemplateType': 'Delivery'}
        return request("post", url, json=task)
