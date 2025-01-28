"""
Tests for f3d
"""
from os import listdir
from terra.loaders import plugins


def test_f3d():
    """
    Test f3d installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'F3d Installer')
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        'plugin',
        'F3d Installer',
        allow_failure=False,
        destination='/apps/f3d'
    )

    # test removal
    handler.remove_plugin(name="F3d Installer", destination="/apps/f3d")