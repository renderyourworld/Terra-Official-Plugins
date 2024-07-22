# <center>Writing Software Installers</center>

## Prerequisites

- [Read Getting Started](getting_started.md)
- Enough Local Storage to install Blender

## Creating a Blender Installer

We are going to create a simple installer which will
automate the entire install process for [Blender](https://www.blender.org/).

### The `plugin` Directory

* Create a new python file in the `plugin` directory
```bash
touch plugins/blender.py
```
* We will also be using a shell script to do the install. Create a shell script under `plugins/scripts` directory
```bash
touch plugins/scripts/blender-installer.sh
```

### Setup Run Environment

* Create a new python file in the `tests` directory
```bash
touch tests/test_blender.py
```

### Writing the Plugin

Now that we have our plugin file, we can start writing our plugin.

```python linenums="1" title="plugins/blender.py" hl_lines="18-27"
--8<-- "plugins/blender.py:1:16"
```

#### Configuration

```python linenums="1" title="Configuration"
--8<-- "plugins/blender.py:18:27"
```

#### Preflight

Next we will add a `preflight` function which will validate the input from
the user and ensure that the plugin can run successfully.

```python linenums="1" title="Preflight" 
--8<-- "plugins/blender.py:28:43"
```

#### Install

Lastly, we will add the `install` function which will execute the plugin.

```python linenums="1" title="Install"
--8<-- "plugins/blender.py:45"
```

##### Shelling Out

In the case of Blender (and many other software installers), it is actually
easier to shell out to the command line to install the software. We will do 
that with pythons `subprocess` module.

```python linenums="1" title="Install" hl_lines="7-13"
--8<-- "plugins/blender.py:45"
```
This will then call a bash script that will install Blender based on the 
arguments passed to it via python.

```shell linenums="1" title="plugins/scripts/blender-installer.sh"
--8<-- "plugins/scripts/blender-installer.sh"
```

#### Final Code

```python linenums="1" title="Final Plugin Code"
--8<-- "plugins/blender.py"
```

### Testing the Plugin

Now that we have written our plugin, we can test it.

> **Note:** TESTS ARE NOT OPTIONAL! You must write tests for your plugin to run.

#### Writing Test Runner

We will write a test runner that will run our plugin.

```python linenums="1" title="tests/test_gitloader.py"
--8<-- "tests/test_blender.py:1:10"
```

#### Loading our Plugin

We will load our plugin and then run it with the field values and `_alias_` we provided above.

```python linenums="1" title="Loading Plugin"
--8<-- "tests/test_blender.py:11"
```

> **Note:** The `/apps` directory is mounted to the runner container and routed to repositories `.apps/` directory.
> This is very useful when you want to check the output of your installer. You can see we use this trick in this test 
> on line 8.

```python linenums="1" title="/apps" hl_lines="2"
 --8<-- "tests/test_blender.py:17:19"
```

#### Running the Test

```bash
make dev-blender
```

We can then check the install with the following command from the root of the repository.

```bash
ls -la .apps/blender
```

## Conclusion

You have now created a simple installer for Blender. This can be expanded to any 
software that you would like to install on your Orion cluster. We currently support 
the following.

- [Blender](https://www.blender.org/)
- [kdenlive](https://kdenlive.org/)
- [PyCharm](https://www.jetbrains.com/pycharm/)
- [Nuke](https://www.foundry.com/products/nuke)
- [ComfyUI](https://github.com/comfyanonymous/ComfyUI)
- and many more to come...

## Next Steps

- [Extensions](extensions.md)
- [Service Installers](service_installers.md)
- [Bundles](bundles.md)
