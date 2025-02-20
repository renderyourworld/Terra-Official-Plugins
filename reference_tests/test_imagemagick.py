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
    plugin = handler.get_plugin("plugin", "Imagemagick Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Imagemagick Installer",
        allow_failure=False,
        destination="/apps/imagemagick",
    )
    handler.remove_plugin(name="Imagemagick Installer", destination="/apps/imagemagick")
