"""
Tests for unreal
"""
from os import listdir
from terra.loaders import plugins


def test_unreal():
    """
    Test unreal installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'unreal Installer')
    assert plugin is not None
    handler.run_plugin(
        'unreal Installer',
        allow_failure=False,
        destination='/apps/unreal'
    )
