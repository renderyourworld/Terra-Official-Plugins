"""
Polaris Essentials Bundle
"""

# std
import os

# 3rd
from terra import Plugin
from terra.loaders import plugins


class PolarisEssentials(Plugin):
    """
    Git Loader
    """

    _version_ = "1.0.0"
    _alias_ = "Polaris Essentials Bundle"
    icon = "https://avatars.githubusercontent.com/u/77702266?s=200&v=4"
    description = "Install the Polaris Essentials Bundle for Polaris Workstation."
    category = "Pipeline"
    tags = ["vfx", "pipeline", "juno", "2d", "visual effects"]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists
        """
        # if not os.path.exists("/pipe"):
        #     raise ValueError(
        #         "The pipeline directory does not exist. Please ensure the pipeline is mounted to /pipe."
        #     )

        # if not os.path.exists("/apps"):
        #     raise ValueError(
        #         "The apps directory does not exist. Please ensure the apps are mounted to /apps."
        #     )

    def install(self, *args, **kwargs) -> None:
        """
        Run install of essential plugins for Polaris Workstation.
        """
        handler = plugins()

        # add firefox
        handler.run_plugin("plugin", "Firefox Browser", allow_failure=False)

        # add WPS Office
        handler.run_plugin(
            "plugin",
            "Wpsoffice Installer",
            allow_failure=False,
            destination="/apps/wpsoffice",
        )

        # add Vlc
        handler.run_plugin(
            "plugin", "Vlc Installer", allow_failure=False, destination="/apps/vlc"
        )

        # add TLM
        handler.run_plugin(
            "plugin", "Tlm Installer", allow_failure=False, destination="/apps/tlm"
        )

        # add user Templates
        handler.run_plugin(
            "plugin",
            "Templates Installer",
            allow_failure=False,
            destination="/apps/templates",
        )

        # add Stardust DISABLED NEEDS PAT
        # handler.run_plugin(
        #     "plugin",
        #     "Stardust",
        #     allow_failure=False,
        #     pat="PERSONAL ACCES TOKEN HERE",
        # )

        # add Sublime3
        handler.run_plugin(
            "plugin",
            "Sublime3 Installer",
            allow_failure=False,
            destination="/apps/sublime3",
            version="3211",
        )

        # add PyCharm
        handler.run_plugin(
            "plugin",
            "PyCharm Installer",
            allow_failure=False,
            destination="/apps/pycharm",
            version="2024.1.4",
        )

        # add PureRef
        handler.run_plugin(
            "plugin",
            "PureRef Installer",
            allow_failure=False,
            destination="/apps/pureref",
            version="2",
        )

        # add obsidian
        handler.run_plugin(
            "plugin",
            "Obsidian Installer",
            allow_failure=False,
            destination="/apps/obsidian",
        )

        # add ocio
        handler.run_plugin(
            "plugin", "Ocio Installer", allow_failure=False, destination="/apps/ocio"
        )

        # add mrv2 player
        handler.run_plugin(
            "plugin",
            "Mrv2 Installer",
            allow_failure=False,
            destination="/apps/mrv2",
            version="Mrv2-1.2.1",
        )

        # add krita
        handler.run_plugin(
            "plugin", "Krita Installer", allow_failure=False, destination="/apps/krita"
        )

