"""
Tests for games
"""
from os import listdir
from terra.loaders import plugins


def test_games():
    """
    Test games installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Games Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Games Installer',
        allow_failure=False,
        destination='/apps/games'
    )
