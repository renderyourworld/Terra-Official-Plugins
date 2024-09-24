"""
Tests for imagestacker
"""
from os import listdir
from terra.loaders import plugins


def test_imagestacker():
    """
    Test imagestacker installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Imagestacker Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Imagestacker Installer",
        allow_failure=False,
        destination="/apps/imagestacker",
    )
