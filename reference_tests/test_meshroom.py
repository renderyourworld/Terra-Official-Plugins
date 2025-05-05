"""
Tests for meshroom
"""
from os import listdir
from terra.loaders import plugins


def test_meshroom():
    """
    Test meshroom installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Meshroom Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Meshroom Installer",
        allow_failure=False,
        destination="/apps/meshroom",
    )
    handler.remove_plugin(name="Meshroom Installer", destination="/apps/meshroom")