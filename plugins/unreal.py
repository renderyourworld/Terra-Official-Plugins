"""
Installer for unreal on linux systems.
"""

# std
import os
from subprocess import run
from pathlib import Path

# 3rd
from terra import Plugin


class unrealInstaller(Plugin):
    """
    unreal installer plugin.
    """

    _version_ = "0.1.0"
    _alias_ = "unreal Installer"
    icon = "https://github.com/juno-fx/Terra-Official-Plugins/blob/main/plugins/assets/missing.png?raw=true"
    description = "unreal"
    category = "Media and Entertainment"
    tags = ["unreal", "editor", "media", "editorial", "kde"]
    fields = [
        Plugin.field("url", "Download URL", required=False),
        Plugin.field("bridge_url", "Download Bridge URL", required=False),
        Plugin.field("destination", "Destination directory", required=True),
        Plugin.field("unreal_version", "Unreal version, 5.4.0, 5.4.4", required=True),
    ]

    def preflight(self, *args, **kwargs) -> bool:
        """
        Check if the target directory exists and validate the arguments passed.
        """
        # store on instance
        self.download_url = kwargs.get(
            "url",
            "https://ucs-blob-store.s3-accelerate.amazonaws.com/blobs/1d/67/9995-2ead-4b8c-9004-2091a21b05c8?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA2SBBZFECCYQWRK6G%2F20240921%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240921T145031Z&X-Amz-Expires=3600&X-Amz-Signature=30c9510a62402ff4eba51d6b00bc62cabaab1dbea8f1af61707c2bfddf4a23ab&X-Amz-SignedHeaders=host&response-content-disposition=inline%3Bfilename%3D%22file.zip%22%3Bfilename%2A%3DUTF-8%27%27Linux_Unreal_Engine_5.4.4.zip&x-id=GetObject",
        )
        self.download_bridge_url = kwargs.get(
            "bridge_url",
            "https://ucs-blob-store.s3-accelerate.amazonaws.com/blobs/16/11/44fe-b519-4e8f-a303-ffa2b0a8f668?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA2SBBZFECCYQWRK6G%2F20240921%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240921T145352Z&X-Amz-Expires=3600&X-Amz-Signature=f3bacace6962d793519c0cfa3a20c9261b111acd0b8a14643cf1ffa897f93bfb&X-Amz-SignedHeaders=host&response-content-disposition=inline%3Bfilename%3D%22file.zip%22%3Bfilename%2A%3DUTF-8%27%27Linux_Bridge_5.4.0_2024.0.1.zip&x-id=GetObject",
        )
        self.destination = Path(kwargs.get("destination")).as_posix()
        self.unreal_version = kwargs.get("unreal_version", "5.4.4")

        # validate
        if not self.destination:
            raise ValueError("No destination directory provided")

        os.makedirs(self.destination, exist_ok=True)

    def install(self, *args, **kwargs) -> None:
        """
        Download and unpack the appimage to the destination directory.
        """
        scripts_directory = os.path.abspath(f"{__file__}/../scripts")
        self.logger.info(f"Loading scripts from {scripts_directory}")
        if (
            run(
                f"bash {scripts_directory}/unreal-installer.sh {self.download_url} {self.destination}  {self.download_bridge_url} {self.unreal_version}",
                shell=True,
                check=False,
            ).returncode
            != 0
        ):
            raise RuntimeError("Failed to install unreal")

    def uninstall(self, *args, **kwargs) -> None:
        """
        Uninstall the application.
        """
        self.logger.info("Uninstalling not implemented")
