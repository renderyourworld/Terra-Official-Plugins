"""
Tests for mrv2
"""
from terra.loaders import plugins


def test_mrv2():
    """
    Test Mrv2 installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Mrv2 Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Mrv2 Installer",
        allow_failure=False,
        destination="/apps/mrv2",
        app_version="1.2.6"
    )
    handler.remove_plugin(name="Mrv2 Installer", destination="/apps/mrv2")