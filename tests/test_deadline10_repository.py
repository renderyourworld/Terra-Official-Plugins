"""
Tests for deadline10_repository
"""
from time import sleep
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
    print("asdfasdfasfdasdfasfdfsda")
    sleep(15)
    response = requests.get("http://deadline-server:8081/", timeout=200)
    print(response.text)
    print(response.status_code)
