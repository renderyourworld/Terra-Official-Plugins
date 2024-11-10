"""
Tests for QuixelBridge
"""
from os import listdir
from terra.loaders import plugins


def test_quixelbridge():
    """
    Test QuixelBridge installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "QuixelBridge Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "QuixelBridge Installer",
        allow_failure=False,
        destination="/apps/quixelbridge",
    )
