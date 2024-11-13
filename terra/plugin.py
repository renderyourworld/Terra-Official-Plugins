"""
Plugin Loader for the service module
"""

# std
import os
import inspect
from traceback import format_exc
from logging import Logger

# 3rd
import pluginlib


@pluginlib.Parent("plugin")
class Plugin:
    """
    Base class for extensions
    """

    _skipload_: bool = True
    icon: str = ""
    description: str = ""
    fields: list[dict] = []
    category: str = "Uncategorized"
    tags: list[str] = []
    context: str = "installer"

    @classmethod
    def source(cls) -> str:
        """
        Create a source
        """
        return inspect.getfile(cls)

    @staticmethod
    def field(
        name: str,
        description: str,
        required: bool = False,
        type: str = "text",
        data: dict = None,
    ) -> dict:
        """
        Create a field
        """
        return {
            "name": name,
            "description": description,
            "required": required,
            "type": type,
            "data": data,
        }

    def update_metadata(self, metadata: dict) -> None:  # pragma: no cover
        """
        Update install metadata
        """
        self.logger.info(f"Updating metadata: {metadata}")
        try:
            import src.plugins.service as service

            service.set_metadata(os.environ["INSTALL_NAME"], metadata)

        except ImportError:
            self.logger.error("Service module not found, running in dev mode.")

    def filter_for_strings_in_metadata(self, metadata: dict) -> dict:
        """
        Filter for strings in metadata (we dont want to store objects)
        """
        filtered_metadata = {}
        self.logger.info(f"Filtering metadata: {metadata}")
        for key, value in metadata.items():
            if isinstance(value, str):
                filtered_metadata[key] = value

        return filtered_metadata

    def __init__(self, logger: Logger):  # pragma: no cover
        """
        Initialize the Plugin
        """
        self.logger = logger
        name = self.__class__._alias_
        if not name:
            name = self.__class__.__name__
        self.logger.info(f"Initializing {name} Plugin")

    def run(self, allow_failure=True, *args, **kwargs) -> None:  # pragma: no cover
        """
        Initialize the Plugin
        """
        _metadata = self.__dict__

        try:
            preflight = self.preflight(*args, **kwargs)
            if preflight or preflight is None:
                self.install(*args, **kwargs)

                self.logger.info("Metadata: ".format(_metadata))

                only_strings_metadata = self.filter_for_strings_in_metadata(_metadata)

                self.update_metadata(only_strings_metadata)

        except Exception as error:
            self.logger.error(f"Error: {error}")
            self.logger.error(format_exc())
            if not allow_failure:
                raise error

    def preflight(self, *args, **kwargs) -> bool:  # pragma: no cover
        """
        Run preflight
        """
        self.logger.info("No custom preflight provided.")
        return True

    @pluginlib.abstractmethod
    def install(self, *args, **kwargs) -> None:  # pragma: no cover
        """
        Run install process
        """
        self.logger.info("No custom installer provided.")

    @staticmethod
    def uninstall(self, *args, **kwargs) -> None:  # pragma: no cover
        """
        Run uninstall process
        """
        self.logger.info("No custom uninstaller provided.")
