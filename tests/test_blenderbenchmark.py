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
    plugin = handler.get_plugin('plugin', 'Blender Benchmark')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Blender Benchmark',
        allow_failure=False,
        destination='/apps/blenderbenchmark'
    )
