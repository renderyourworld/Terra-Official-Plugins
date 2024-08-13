"""
Tests for hdrmerge
"""
from os import listdir
from terra.loaders import plugins


def test_hdrmerge():
    """
    Test hdrmerge installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Hdrmerge Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Hdrmerge Installer',
        allow_failure=False,
        destination='/apps/hdrmerge'
    )
