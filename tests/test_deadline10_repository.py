"""
Tests for deadline10_repository
"""
from os import listdir
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
