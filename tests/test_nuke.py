"""
Tests for nuke
"""
from terra.loaders import plugins


def test_nuke():
    """
    Test nuke installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Nuke Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Nuke Installer',
        allow_failure=False,
        destination='/apps/nuke',
        version='Nuke14.0v2'
    )
    # assert 'README.md' in listdir('/tmp/terra')
