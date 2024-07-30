"""
Tests for kdenlive
"""
from os import listdir
from terra.loaders import plugins


def test_kdenlive():
    """
    Test kdenlive installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Krita Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Krita Installer',
        allow_failure=False,
        destination='/apps/krita'
    )
