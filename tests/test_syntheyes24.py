"""
Tests for syntheyes24
"""
from os import listdir
from terra.loaders import plugins


def test_syntheyes24():
    """
    Test Syntheyes24 installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Syntheyes24 Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Syntheyes24 Installer",
        allow_failure=False,
        destination="/apps/syntheyes24",
    )
