"""
Tests for Katana7
"""
from os import listdir
from terra.loaders import plugins


def test_katana7():
    """
    Test Katana7 installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Katana7 Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin", "Katana7 Installer", allow_failure=False, destination="/apps/katana7"
    )
