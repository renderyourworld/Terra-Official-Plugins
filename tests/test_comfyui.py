"""
Tests for comfyui
"""
from terra.loaders import plugins


def test_comfyui():
    """
    Test comfyui installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "ComfyUI Installer")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin(
        "ComfyUI Installer", allow_failure=False, destination="/apps/comfyui"
    )
    #handler.remove_plugin(name="ComfyUI Installer", destination="/apps/comfyui")