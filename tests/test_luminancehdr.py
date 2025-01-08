"""
Tests for luminancehdr
"""
from os import listdir
from terra.loaders import plugins


def test_luminancehdr():
    """
    Test Luminancehdr installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Luminancehdr Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Luminancehdr Installer",
        allow_failure=False,
        destination="/apps/luminancehdr",
    )
    handler.remove_plugin(name="Luminancehdr Installer", destination="/apps/luminancehdr")