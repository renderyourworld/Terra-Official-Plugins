"""
Tests for Rawtherapee
"""
from os import listdir
from terra.loaders import plugins


def test_rawtherapee():
    """
    Test Rawtherapee installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Rawtherapee Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Rawtherapee Installer",
        allow_failure=False,
        destination="/apps/rawtherapee",
    )
