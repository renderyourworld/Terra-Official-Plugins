
# 3rd
from terra import Workflow


class Example(Workflow):
    """
    Example Workflow
    """

    _version_ = "1.0.0"
    _alias_ = "Example Workflow"
    icon = "fas fa-code"
    description = "Example Workflow"
    category = "Example"
    tags = ["example"]
    context = "hubble"

    def run(self, *args, **kwargs) -> None:
        """
        Run the workflow
        """
        self.logger.info("Running Example Workflow")
        self.logger.info(f"Args: {args}")
        self.logger.info(f"Kwargs: {kwargs}")
        self.logger.info("Example Workflow Complete")
