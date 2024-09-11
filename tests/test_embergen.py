"""
Tests for embergen
"""
from os import listdir
from terra.loaders import plugins


def test_embergen():
    """
    Test Embergen installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Embergen Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Embergen Installer",
        allow_failure=False,
        destination="/apps/embergen",
    )
