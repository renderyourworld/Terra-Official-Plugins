"""
Tests for Appleseed
"""
from os import listdir
from terra.loaders import plugins


def test_appleseed():
    """
    Test Appleseed installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Appleseed Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Appleseed Installer",
        allow_failure=False,
        destination="/apps/appleseed",
    )
