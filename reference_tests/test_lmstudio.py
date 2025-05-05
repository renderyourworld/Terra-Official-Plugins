"""
Tests for lmstudio
"""
from os import listdir
from terra.loaders import plugins


def test_lmstudio():
    """
    Test lmstudio installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'LM-Studio Installer')
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        'LM-Studio Installer',
        allow_failure=False,
        destination='/apps/lmstudio'
    )

    # test removal
    #handler.remove_plugin(name="LM-Studio Installer", destination="/apps/lmstudio")