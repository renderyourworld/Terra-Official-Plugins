"""
Tests for sublime3
"""
from terra.loaders import plugins


def test_nuke():
    """
    Test sublime3 installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Sublime3 Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Sublime3 Installer",
        allow_failure=False,
        destination="/apps/sublime3",
        version="3211",
    )
    handler.remove_plugin(name="Sublime3 Installer", destination="/apps/sublime3")