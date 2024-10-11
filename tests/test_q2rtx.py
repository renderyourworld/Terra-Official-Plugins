"""
Tests for q2rtx
"""
from os import listdir
from terra.loaders import plugins


def test_q2rtx():
    """
    Test q2rtx installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Q2rtx Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin", "Q2rtx Installer", allow_failure=False, destination="/apps/q2rtx"
    )
