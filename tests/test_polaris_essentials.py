"""
Tests for juno_pipeline
"""
from terra.loaders import plugins


def test_juno_pipeline():
    """
    Test polaris essentials installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Templates Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin("plugin", "Polaris Essentials Bundle", allow_failure=False)
