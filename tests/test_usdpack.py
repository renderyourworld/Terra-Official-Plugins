"""
Tests for usdpack
"""
from os import listdir
from terra.loaders import plugins


def test_usdpack():
    """
    Test usdpack installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "UsdPack Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin", "UsdPack Installer", allow_failure=False, destination="/apps/usd"
    )
