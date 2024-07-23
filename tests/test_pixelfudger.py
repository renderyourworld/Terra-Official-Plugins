"""
Tests for pixelfudger
"""
from terra.loaders import plugins


def test_pixelfudger():
    """
    Test pixelfudger installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Pixelfudger v3.2')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Pixelfudger v3.2',
        allow_failure=False,
        destination='/apps/pixelfudger'
    )
