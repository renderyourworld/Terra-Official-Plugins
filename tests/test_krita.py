"""
Tests for kdenlive
"""
from os import listdir
from terra.loaders import plugins


def test_krita():
    """
    Test kdenlive installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Krita Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Krita Installer", allow_failure=False, destination="/apps/krita"
    )
