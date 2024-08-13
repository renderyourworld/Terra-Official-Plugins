"""
Tests for xnview
"""
from os import listdir
from terra.loaders import plugins


def test_obsidian():
    """
    Test xnview installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Obsidian Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Obsidian Installer',
        allow_failure=False,
        destination='/apps/obsidian'
    )
