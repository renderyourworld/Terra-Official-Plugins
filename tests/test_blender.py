"""
Tests for blender
"""
from terra.loaders import plugins


def test_blender():
    """
    Test blender installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Blender Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Blender Installer",
        allow_failure=False,
        destination="/apps/blender",
        version="4.2.1",
    )
