"""
Tests for obsidian installer.
"""
from os import listdir
from terra.loaders import plugins


def test_obsidian():
    """
    Test obsidian installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Obsidian Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Obsidian Installer",
        allow_failure=False,
        destination="/apps/obsidian",
    )
