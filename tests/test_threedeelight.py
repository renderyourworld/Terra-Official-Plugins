"""
Tests for Threedeelight
"""
from os import listdir
from terra.loaders import plugins


def test_threedeelight():
    """
    Test Threedeelight installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Threedeelight Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Threedeelight Installer',
        allow_failure=False,
        destination='/apps/3delight'
    )
