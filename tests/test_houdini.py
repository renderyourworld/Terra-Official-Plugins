"""
Tests for houdini
"""
from terra.loaders import plugins


def test_houdini():
    """
    Test houdini installer.
    """
    handler = plugins()
    plugin = handler.get_plugin('plugin', 'Houdini Installer')
    assert plugin is not None
    handler.run_plugin(
        'plugin',
        'Houdini Installer',
        allow_failure=False,
        destination='/apps/houdini',
        version='20.0.668',
        client_id='DJTcFgmhP6ctjL1bME58BBvZGHEWZQ5FhIzFRTnT',
        client_secret='scNmefEt2B6qQEYyf9S78EOoLTzSRiAzFps5gJuZScrchZxiMKUawRi0SmiiadHlO65HYLb4A7ud9Yg8keWuxGyLu4bw3uWzZH8GVUfz4TPsFdgFGOj5MZHOE63LkO6Z'
    )
