"""
Tests for xnview
"""
from os import listdir
from terra.loaders import plugins


def test_xnview():
    """
    Test xnview installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Xnview Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Xnview Installer", allow_failure=False, destination="/apps/xnview"
    )
    handler.remove_plugin(name="Xnview Installer", destination="/apps/xnview")