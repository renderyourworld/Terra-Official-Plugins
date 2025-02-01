"""
Juno's Pipeline Bundle
"""

# std
import os
from subprocess import run
from requests import request

# 3rd
from terra import Plugin


class JunoPipeline(Plugin):
    """
    Juno Pipeline Installer
    """

    _version_ = "1.0.0"
    _alias_ = "Juno Pipeline (Full)"
    icon = "https://avatars.githubusercontent.com/u/77702266?s=200&v=4"
    description = "Install the Juno Pipeline for 2D Visual Effects. Ships with Juno Nuke"
    category = "Pipeline"
    tags = ["vfx", "pipeline", "juno", "2d", "visual effects"]


    def install(self, *args, **kwargs) -> None:
        """
        Create our ShowPrep Task and install nuke
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

        print('Preparing Nuke 15.1v1 install')
        nuke_destination = "/apps/nuke"

        install_url = 'http://terra:8000/plugins/install'
        data = {
            'install_name': 'Nuke Pipeline 15.1v1',
            'plugin_name': 'Nuke Installer',
            'fields': {
                'version': 'Nuke15.1v1',
                'destination': nuke_destination,
            }
        }
        request("post", install_url, json=data)
        print('Preparing To create for Juno Nuke Desktop File')
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        if (
            run(
                f"bash {scripts_directory}/juno-pipeline-installer.sh {nuke_destination}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install Nuke")

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