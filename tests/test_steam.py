"""
Tests for steam
"""
from os import listdir
from terra.loaders import plugins


def test_steam():
    """
    Test steam installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Steam Client')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Steam Client',
        allow_failure=False,
        destination='/apps/steam'
    )
