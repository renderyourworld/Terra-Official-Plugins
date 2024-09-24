"""
Tests for handbrake
"""
from os import listdir
from terra.loaders import plugins


def test_handbrake():
    """
    Test handbrake installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Handbrake Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Handbrake Installer",
        allow_failure=False,
        destination="/apps/handbrake",
    )
