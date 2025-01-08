"""
Tests for gaffer
"""
from os import listdir
from terra.loaders import plugins


def test_gaffer():
    """
    Test gaffer installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Gaffer Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Gaffer Installer", allow_failure=False, destination="/apps/gaffer"
    )

    handler.remove_plugin(name="Gaffer Installer", destination="/apps/gaffer")