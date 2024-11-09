"""
Tests for silhouette2024
"""
from os import listdir
from terra.loaders import plugins


def test_silhouette2024():
    """
    Test silhouette2024 installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Silhouette2024 Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Silhouette2024 Installer",
        allow_failure=False,
        destination="/apps/silhouette2024",
    )
