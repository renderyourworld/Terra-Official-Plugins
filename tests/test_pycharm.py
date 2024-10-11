"""
Tests for pycharm
"""
from terra.loaders import plugins


def test_pycharm():
    """
    Test pycharm installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "PyCharm Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "plugin",
        "PyCharm Installer",
        allow_failure=False,
        destination="/apps/pycharm",
        version="2024.1.4",
    )
