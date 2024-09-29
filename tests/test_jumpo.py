"""
Tests for jumpo
"""
from os import listdir
from terra.loaders import plugins


def test_jumpo():
    """
    Test jumpo installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Jumpo Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Jumpo Installer',
        allow_failure=False,
        ssh_key='dalsjdkhaskjdhaksjdhakjshdas87dqy93482y3iejrnbakdas'
    )
