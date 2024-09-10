"""
Tests for Storyboard
"""
from os import listdir
from terra.loaders import plugins


def test_storyboard():
    """
    Test Storyboard installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Storyboard Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Storyboard Installer",
        allow_failure=False,
        destination="/apps/storyboard",
    )
