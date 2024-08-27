"""
Tests for alab
"""
from os import listdir
from terra.loaders import plugins


def test_alab():
    """
    Test alab installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Alab Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Alab Installer',
        allow_failure=False,
        destination='/apps/alab'
    )
