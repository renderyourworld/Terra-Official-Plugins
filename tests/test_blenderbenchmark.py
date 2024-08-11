"""
Tests for blenderbenchmark
"""
from os import listdir
from terra.loaders import plugins


def test_blenderbenchmark():
    """
    Test blenderbenchmark installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Blenderbenchmark Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Blenderbenchmark Installer',
        allow_failure=False,
        destination='/apps/blenderbenchmark'
    )
