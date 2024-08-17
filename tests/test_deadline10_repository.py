"""
Tests for deadline10_repository
"""
from os import listdir
import requests
from terra.loaders import plugins


def test_deadline10_repository():
    """
    Test deadline10_repository installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Deadline10_repository Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Deadline10_repository Installer',
        allow_failure=False,
        destination='/apps/deadline10/repository'
    )
    response = requests.get("http://deadline-server:8081", timeout=30)
    print(response.text)
