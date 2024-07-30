"""
Tests for PureRef
"""
from terra.loaders import plugins


def test_pureref():
    """
    Test PureRef installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'PureRef Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'PureRef Installer',
        allow_failure=False,
        destination='/apps/pureref',
        version='2'
    )
