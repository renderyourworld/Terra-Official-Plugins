"""
Tests for Deadline10_client
"""
from os import listdir
from terra.loaders import plugins


def test_deadline10client():
    """
    Test deadline10client installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Deadline10_client Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Deadline10_client Installer',
        allow_failure=False,
        destination='/apps/deadline10/client'
    )
