"""
Tests for ocio
"""
from os import listdir
from terra.loaders import plugins


def test_ocio():
    """
    Test ocio installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Ocio Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Ocio Installer", allow_failure=False, destination="/apps/ocio"
    )
    handler.remove_plugin(name="Ocio Installer", destination="/apps/ocio")