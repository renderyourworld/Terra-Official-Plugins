"""
Tests for deadline10_repository
"""
from time import sleep
import requests
from terra.loaders import plugins


def test_deadline10():
    """
    Test deadline10_repository installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Deadline10 Installer')
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        'plugin',
        'Deadline10 Installer',
        allow_failure=False,
        destination='/apps/deadline10',
        install_volume='terra-test-claim',
        database_volume='terra-test-claim',
    )

    sleep(200)
    response = requests.get("http://deadline-server:8081/", timeout=600)
    print(response)
    print(response.text)
    print(response.status_code)
