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

INSTALL_URL = 'http://terra:8000/plugins/install'

class JunoPipeline(Plugin):
    """
    Juno Pipeline Installer
    """

    _version_ = "1.0.0"
    _alias_ = "Orion Essentials"
    icon = "https://avatars.githubusercontent.com/u/77702266?s=200&v=4"
    description = "Install our Orion Essentials bundle. includes Firefox and WPS Office."
    category = "Utility"
    tags = ["firefox", "web", "browser", "wpsoffice", "office", "word", "excel", "essential"]

    def preflight(self, *args, **kwargs) -> bool:
        """
        run a preflight check
        """

        print('Preflight Checked')

    def install(self, *args, **kwargs) -> None:
        """
        Create our ShowPrep Task and install nuke
        """

        # Install our preferred Apps automatically
        self.install_wps()
        self.install_firefox()

    def install_firefox(self):
        """
        installs firefox
        """

        self.logger.info('Preparing to install Fire fox')
        data = {
            'install_name': 'Firefox',
            'plugin_name': 'Firefox Browser',
            'fields': {}
        }
        response = request("post", INSTALL_URL, json=data)
        if response.status_code != 200:
            raise HTTPException(f'Firefox Install Error {response.status_code}: {response.text}')

    def install_wps(self):
        """
        install WPS office
        """
        self.logger.info('Preparing WPS install')

        data = {
            'install_name': 'Nuke15 Pipeline',
            'plugin_name': 'WPS',
            'fields': {'destination': '/apps/wps'}
        }
        response = request("post", INSTALL_URL, json=data)
        if response.status_code != 200:
            raise HTTPException(f'WPS Install Error {response.status_code}: {response.text}')

        self.logger.info(f'WPS Install Requested: {response.status_code}: {response.text}')


    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
