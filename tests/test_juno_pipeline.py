"""
Tests for juno_pipeline
"""
import requests
from terra.loaders import plugins


def test_juno_pipeline():
    """
    Test juno_pipeline installer.
    """
    handler = plugins()
    plugin = handler.get_plugin("plugin", "Juno Pipeline (Full)")
    assert plugin is not None
    assert plugin._version_ is not None
    handler.run_plugin("Juno Pipeline (Full)", allow_failure=False)

    delivery_task = {"code": "DeliveryTemplate", "parent": None, "type": 1040}
    luna_url = "http://luna:8000/"
    meta_url = f"{luna_url}/meta/filter"
    response = requests.post(f"{meta_url}", json=delivery_task, timeout=600)
    assert type(response.json()) == list
    assert len(response.json()) == 1
