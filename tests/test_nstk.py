"""
Tests for NukeSurvivalToolkit
"""
from terra.loaders import plugins


def test_NukeSurvivalToolkit():
    """
    Test NukeSurvivalToolkit installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Nuke Survival Toolkit v2.1.1")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Nuke Survival Toolkit v2.1.1",
        allow_failure=False,
        destination="/apps/nukesurvivalkit",
    )
