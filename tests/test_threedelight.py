"""
Tests for threedelight
"""
from os import listdir
from terra.loaders import plugins


def test_threedelight():
    """
    Test threedelight installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Threedelight Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Threedelight Installer",
        allow_failure=False,
        destination="/apps/3delight",
    )
