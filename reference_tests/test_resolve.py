"""
Tests for Resolve
"""
from os import listdir
from terra.loaders import plugins


def test_resolve():
    """
    Test Resolve installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Resolve Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Resolve Installer",
        allow_failure=False,
        destination="/apps/resolve",
        version_to_install="18",
    )
    handler.remove_plugin(name="Resolve Installer", destination="/apps/resolve")