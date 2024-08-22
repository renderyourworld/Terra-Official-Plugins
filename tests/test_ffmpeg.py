"""
Tests for ffmpeg
"""
from os import listdir
from terra.loaders import plugins


def test_ffmpeg():
    """
    Test ffmpeg installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Ffmpeg Support')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Ffmpeg Support',
        allow_failure=False,
        destination='/apps/ffmpeg'
    )
