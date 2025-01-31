"""
Juno's Pipeline Bundle
"""

# std
import os
from subprocess import run
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
        # ShowPrep Task called DeliveryTemplate
        delivery_task = {"code": "DeliveryTemplate", "parent": None, "type": 1140}
        luna_url = "http://luna:8000/"
        meta_url = f"{luna_url}/meta"

        response = self.get_task(url=meta_url, task=delivery_task)
        status_code = response.status_code

        if status_code == 200 and not response.json():
            response = self.create_task(url=meta_url, task=delivery_task)
            if response.status_code == 200:
                print('ShowPrep task Created')

        handler = plugins()
        print('Preparing Nuke 15.1v1 install')
        handler.run_plugin(
            "Nuke Pipeline Install",
            "Nuke Installer",
            allow_failure=False,
            destination="/apps/nuke",
            version="Nuke15.1v1",

        )
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        if (
            run(
                f"bash {scripts_directory}/juno-pipeline-installer.sh Nuke15.1v1 /apps/nuke",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Nuke")

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
        print("CREATING TASK")
        task["metadata"] = {"TemplateType": "Delivery"}
        print(task)
        return request("post", url, json=task)

    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
