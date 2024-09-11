"""
Tests for tlm
"""
from os import listdir
from terra.loaders import plugins


def test_tlm():
    """
    Test xnview installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Tlm Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin", "Tlm Installer", allow_failure=False, destination="/apps/tlm"
    )
