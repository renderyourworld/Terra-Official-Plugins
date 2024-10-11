"""
Tests for audacity
"""
from os import listdir
from terra.loaders import plugins


def test_audacity():
    """
    Test audacity installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Audacity Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Audacity Installer",
        allow_failure=False,
        destination="/apps/audacity",
    )
