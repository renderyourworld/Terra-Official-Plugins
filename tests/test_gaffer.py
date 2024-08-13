"""
Tests for gaffer
"""
from os import listdir
from terra.loaders import plugins


def test_gaffer():
    """
    Test gaffer installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Gaffer Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Gaffer Installer',
        allow_failure=False,
        destination='/apps/gaffer'
    )
