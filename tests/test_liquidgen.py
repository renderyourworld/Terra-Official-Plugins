"""
Tests for liquidgen
"""
from os import listdir
from terra.loaders import plugins


def test_liquidgen():
    """
    Test liquidgen installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'LiquidGen Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'LiquidGen Installer',
        allow_failure=False,
        destination='/apps/liquidgen'
    )
