"""
Juno's Pipeline Bundle
"""

# std
import os
from http.client import HTTPException
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

    def preflight(self, *args, **kwargs) -> bool:
        """
        run a preflight check
        """

        print('Preflight Checked')

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

        # Install our preferred Apps automatically
        install_url = 'http://terra:8000/plugins/install'

        self.install_juno_nuke(install_url=install_url)
        self.install_firefox(install_url=install_url)

    def install_firefox(self, install_url):
        """
        installs firefox
        """

        self.logger.info('Preparing to install Fire fox')
        data = {
            'install_name': 'Firefox',
            'plugin_name': 'Firefox Browser',
        }
        response = request("post", install_url, json=data)
        if response.status_code != 200:
            raise HTTPException(f'Firefox Install Error {response.status_code}: {response.text}')

    def install_juno_nuke(self, install_url):
        """
        install the preferred nuke version and create our juno nuke desktop file
        """
        self.logger.info('Preparing Nuke 15.1v1 install')
        nuke_destination = "/apps/nuke"


        data = {
            'install_name': 'Nuke15 Pipeline',
            'plugin_name': 'Nuke Installer',
            'fields': {
                'version': 'Nuke15.1v1',
                'destination': nuke_destination,
            }
        }
        response = request("post", install_url, json=data)
        if response.status_code != 200:
            raise HTTPException(f'Nuke Install Error {response.status_code}: {response.text}')

        self.logger.info(f'Nuke Install Requested: {response.status_code}: {response.text}')
        self.logger.info('Preparing To create for Juno Nuke Desktop File')
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        if (
                run(
                    f"bash {scripts_directory}/juno-pipeline-installer.sh {nuke_destination}",
                    shell=True,
                    check=False,
                ).returncode
                != 0
        ):
            raise RuntimeError("Failed to create juno nuke desktop file")

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
