"""
Tests for filezilla
"""
from os import listdir
from terra.loaders import plugins


def test_filezilla():
    """
    Test Filezilla installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Filezilla Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "Filezilla Installer", allow_failure=False, destination="/apps/filezilla"
    )
    #handler.remove_plugin(name="Filezilla Installer", destination="/apps/filezilla")
