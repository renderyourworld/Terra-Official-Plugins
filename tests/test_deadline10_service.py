"""
Tests for Deadline10_service
"""
from os import listdir
from terra.loaders import plugins


def test_deadline10_service():
    """
    Test deadline10_service installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Deadline10_service Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Deadline10_service Installer',
        allow_failure=False,
        destination='/apps/deadline10/service'
    )
