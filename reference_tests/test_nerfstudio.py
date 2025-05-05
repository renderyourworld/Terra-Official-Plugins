"""
Tests for nerfstudio
"""
from os import listdir
from terra.loaders import plugins


def test_nerfstudio():
    """
    Test nerfstudio installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'NerfStudio Installer')
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        'NerfStudio Installer',
        allow_failure=False,
        destination='/apps/nerfstudio'
    )

    # test removal
    handler.remove_plugin(name="NerfStudio Installer", destination="/apps/nerfstudio")