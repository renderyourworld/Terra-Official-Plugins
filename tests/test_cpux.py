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
    plugin = handler.get_plugin('plugin', 'CpuX Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'CpuX Installer',
        allow_failure=False,
        destination='/apps/cpux'
    )
