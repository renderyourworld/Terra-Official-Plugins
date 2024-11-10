"""
Tests for juno_pipeline
"""
from terra.loaders import plugins


def test_juno_pipeline():
    """
    Test juno_pipeline installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "PyCharm Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin("Juno Pipeline (Full)", allow_failure=False)
