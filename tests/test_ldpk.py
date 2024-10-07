"""
Tests for ldpk
"""
from os import listdir
from terra.loaders import plugins


def test_ldpk():
    """
    Test ldpk installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'ldpk Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'ldpk Installer',
        allow_failure=False,
        destination='/apps/ldpk'
    )
