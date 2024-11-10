"""
Tests for downloader
"""
from terra.loaders import plugins


def test_downloader():
    """
    Test downloader installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Downloader")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Downloader",
        allow_failure=False,
        destination="/apps/download",
        url="https://www.google.com/images/branding/googlelogo/2x/googlelogo_light_color_92x30dp.png",
    )
