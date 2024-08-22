"""
Tests for vlc
"""
from os import listdir
from terra.loaders import plugins


def test_vlc():
    """
    Test vlc installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Vlc Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Vlc Installer',
        allow_failure=False,
        destination='/apps/vlc'
    )
