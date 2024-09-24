"""
Tests for stardust
"""
from os import listdir
from terra.loaders import plugins


def test_stardust():
    """
    Test stardust installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Stardust")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "Stardust",
        allow_failure=False,
        pat="PERSONAL ACCES TOKEN HERE",
    )
