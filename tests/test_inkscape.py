"""
Tests for Inkscape
"""
from os import listdir
from terra.loaders import plugins


def test_inkscape():
    """
    Test Inkscape installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Inkscape Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Inkscape Installer",
        allow_failure=False,
        destination="/apps/inkscape",
    )
    handler.remove_plugin(name="Inkscape Installer", destination="/apps/inkscape")