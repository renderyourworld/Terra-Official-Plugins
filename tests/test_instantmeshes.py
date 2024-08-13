"""
Tests for instantmeshes
"""
from os import listdir
from terra.loaders import plugins


def test_instantmeshes():
    """
    Test instantmeshes installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Instantmeshes Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Instantmeshes Installer',
        allow_failure=False,
        destination='/apps/instantmeshes'
    )
