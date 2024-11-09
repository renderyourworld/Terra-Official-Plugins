"""
Tests for geogen
"""
from os import listdir
from terra.loaders import plugins


def test_geogen():
    """
    Test geogen installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "GeoGen Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "GeoGen Installer", allow_failure=False, destination="/apps/geogen"
    )
