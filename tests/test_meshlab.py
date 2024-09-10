"""
Tests for Meshlab
"""
from os import listdir
from terra.loaders import plugins


def test_meshlab():
    """
    Test kdenlive installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Meshlab Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin", "Meshlab Installer", allow_failure=False, destination="/apps/meshlab"
    )
