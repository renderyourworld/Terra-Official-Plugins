"""
Tests for flameshot
"""
from os import listdir
from terra.loaders import plugins


def test_flameshot():
    """
    Test flameshot installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Flameshot Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Flameshot Installer',
        allow_failure=False,
        destination='/apps/flameshot'
    )
