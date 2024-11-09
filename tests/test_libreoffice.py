"""
Tests for Libreoffice
"""
from os import listdir
from terra.loaders import plugins


def test_libreoffice():
    """
    Test Libreoffice installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Libreoffice Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Libreoffice Installer",
        allow_failure=False,
        destination="/apps/libreoffice",
    )
