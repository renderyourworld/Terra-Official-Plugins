"""
Tests for templates
"""
from os import listdir
from terra.loaders import plugins


def test_templates():
    """
    Test templates installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Templates Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Templates Installer",
        allow_failure=False,
        destination="/apps/templates",
    )
    handler.remove_plugin(name="Templates Installer", destination="/apps/templates")