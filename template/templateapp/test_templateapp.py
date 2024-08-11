"""
Tests for templateapp
"""
from os import listdir
from terra.loaders import plugins


def test_templateapp():
    """
    Test templateapp installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'templateapp Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'templateapp Installer',
        allow_failure=False,
        destination='/apps/templateapp'
    )
