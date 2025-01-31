import os
import pathlib

import click


@click.command()
@click.option("--app_name", default="20.0.668", help="Set Houdini version, default is 20.0")
@click.option("--version", default="/apps/houdini", help="installation directory")
@click.option("--latest_path", default="None")
@click.option("--categories", default="None")
@click.option("--debug", default="None")
@click.option("--destination", default="None")
@click.option("--icon", default="None")
@click.option("--terminal", default="None")
@click.option("--junogl", default="None")
def create_desktop_file(
    app_name=None,
    version=None,
    latest_path=None,
    categories=None,
    debug=None,
    destination=None,
    icon=None,
    terminal=None,
    junogl=None,
):
    """Create a desktop file for the application based on the provided arguments."""

    # update terminal option - donest break current runs!
    # desktop files need to be lowercase true or false
    if terminal == "True":
        terminal = "true"
    else:
        terminal = "false"

    # update junogl option - dont break current runs!
    if junogl == "True":
        junogl_run = "junogl "
    else:
        junogl_run = ""


    desktop_file = f"""[Desktop Entry]
Name={app_name} {version}
Exec={junogl_run}{latest_path}
Terminal={terminal}
Type=Application
Categories=X-Polaris
Icon={icon}"""
    desktop_path = destination + "/" + app_name.lower() + "_" + version + ".desktop"
    desktop_path = pathlib.Path(desktop_path).as_posix()
    with open(desktop_path, "w") as f:
        f.write(desktop_file)

    print(f"Desktop file created at {desktop_path}")


if __name__ == "__main__":
    create_desktop_file()
