import os
import click
@click.command()
@click.option("--app_name", default="20.0.668", help="Set Houdini version, default is 20.0")
@click.option("--version", default="/apps/houdini", help="installation directory")
@click.option("--latest_path", default="None")
@click.option("--categories", default="None")
@click.option("--debug", default="None")
def create_desktop_file(app_name=None, version=None, latest_path=None, categories=None, debug=None):

    if debug:
        dsktp_files = "/home/des/_juno/Terra-Official-Plugins/.apps/applications"
    else:
        dsktp_files = "/apps/applications"

    desktop_file = f'''[Desktop Entry]
Name={app_name} {version}
Exec=terminator -x {latest_path}
Terminal=true
Type=Application
Categories=Juno, {categories}"
    '''
    with open(f"{dsktp_files}/{app_name}_{version}.desktop", "w") as f:
        f.write(desktop_file)
