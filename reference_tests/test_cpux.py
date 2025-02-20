"""
Tests for CpuX
"""
from os import listdir
from terra.loaders import plugins


def test_cpux():
    """
    Test xnview installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "CpuX Installer")
    assert plugin is not None
    assert plugin._version_ is not None

    handler.run_plugin(
        "CpuX Installer", allow_failure=False, destination="/apps/cpux"
    )
    handler.remove_plugin(name="CpuX Installer", destination="/apps/cpux")
