"""
Handles installing PureRef to a target directory.
PureRef - Simple and lightweight reference image viewer.
"""

# std
import os
from subprocess import run
import requests

# 3rd
from terra import Plugin



def download_file_from_google_drive(gid, destination):
    """Download file from Google Drive."""
    def get_confirm_token(response):
        for key, value in response.cookies.items():
            if key.startswith('download_warning'):
                return value

        return None

    def save_response_content(response, destination):
        """Save response content."""
        chunk_size = 32768

        with open(destination, "wb") as f:
            for chunk in response.iter_content(chunk_size):
                if chunk:
                    f.write(chunk)

    gurl = "https://docs.google.com/uc?export=download"

    session = requests.Session()

    response = session.get(gurl, params = { 'id' : gid }, stream = True)
    token = get_confirm_token(response)

    if token:
        params = { 'id' : gid, 'confirm' : token }
        response = session.get(gurl, params = params, stream = True)

    save_response_content(response, destination)



class PureRefInstaller(Plugin):
    """
    PureRef
    """
    _alias_ = "PureRef Installer"
    # pylint: disable=line-too-long
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/pack-additional-software/plugins/assets/pureref.png?raw=true"
    description = "Install PureRef to a target directory."
    category = "Media and Entertainment"
    tags = ["PureRef", "references", "media", "vfx", "visual effects", "images"]
    fields = [
        Plugin.field("url", "Download URL", required=False),
        Plugin.field("destination", "Destination directory", required=True),
    ]

    # pylint: disable=unused-argument
    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        # pylint: disable=attribute-defined-outside-init
        self.download_url = kwargs.get(
            "url",
            "https://drive.google.com/file/d/1FBh5-xB7tZnrK6JuzjcKY5Fx7PVQf4pK",
        )
        self.destination = kwargs.get("destination")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        if not self.destination.endswith("/"):
            self.destination += "/"

        os.makedirs(self.destination, exist_ok=True)

    # pylint: disable=unused-argument
    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the PureRef.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")

        # TAKE ID FROM SHAREABLE LINK
        file_id = "1FBh5-xB7tZnrK6JuzjcKY5Fx7PVQf4pK"
        # DESTINATION FILE ON YOUR DISK
        file_destination = "/tmp/pureref2.Appimage"
        download_file_from_google_drive(file_id, file_destination)

        if os.path.exists(file_destination):
            if (
                run(
                    f"bash {scripts_directory}/PureRef-installer.sh  {file_destination}  {self.destination}",
                    shell=True,
                    check=False,
                ).returncode
                != 0
            ):
                raise RuntimeError("Failed to install PureRef")

        else:
            raise RuntimeError("Failed to download PureRef")
