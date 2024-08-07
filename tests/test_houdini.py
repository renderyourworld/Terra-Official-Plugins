"""
Tests for houdini
"""
from terra.loaders import plugins


def test_houdini():
    """
    Test houdini
     installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Houdini Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Houdini Installer',
        allow_failure=False,
        destination='/apps/houdini',
        version='20.5.278'
    )
