"""
Tests for Imagemagick
"""
from os import listdir
from terra.loaders import plugins


def test_imagemagick():
    """
    Test Imagemagick installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Imagemagick Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Imagemagick Installer',
        allow_failure=False,
        destination='/apps/imagemagick'
    )
