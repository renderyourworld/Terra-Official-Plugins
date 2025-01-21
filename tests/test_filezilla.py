"""
Tests for filezilla
"""
from os import listdir
from terra.loaders import plugins


def test_filezilla():
    """
    Test Filezilla installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Filezilla Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Filezilla Installer',
        allow_failure=False,
        destination='/apps/filezilla'
    )
