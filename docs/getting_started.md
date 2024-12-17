# <center>Writing Our First Plugin</center>

## Prerequisites 

> **Note:** While you can use Windows, we prefer you use a Linux environment for development.

1. Clone the Terra repository
```bash
git clone https://github.com/juno-fx/Terra-Official-Plugins.git
```

2. Change directory to the Terra repository
```bash
cd Terra-Official-Plugins
```

Once here, you need to have the following installed on your system:

- [Python 3.12](https://www.python.org/downloads/) - Programming language
- [Docker](https://docs.docker.com/get-docker/) - Containerization platform
- [kind](https://kind.sigs.k8s.io/) - Kubernetes in Docker
- [skaffold](https://skaffold.dev/) - Kubernetes development tool
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) - Kubernetes command-line tool
- [make](https://www.gnu.org/software/make/) - Build automation tool

Terra ships with the fully configured development environment, so you can get started quickly. 
If you are curious, you can take a look in the `k8s` directory at the root of this repository.

## Preparing Development Environment

1. Setup your virtual environment and install all dependencies
```bash
make install
```

## Creating a New Plugin from Template

The repository comes with a template plugin that you can use to get started.
To create a new plugin from the template, you can run the following command:

```bash
make app-houdini22.5
```
The make command will copy the template plugins structure in all required directories and rename the files to match the new plugin name.

The plugins files will need to be edited to match the new plugin name and description.

Check the plugin python files in plugins/ and plugins/scripts directories and update the plugin name and description. Add the links or fields necesary for the plugin to work.
Change the shell script in the plugins/scripts directory to do what your app would need to do like in a regular shell session.

Usualy there is a download link to curl or wget and a destination directory to install the downloaded file passed from python to shell script.

Add an icon to the plugins directory with the name of the plugin and the extension .png.
This icon will be used in the Terra UI. You can provide an url to an image or use a local image.
The plugin will be ready to be tested after the changes are made.

You are not bound to this template by any means, this just show the easy way to create a new plugin from template with boilerplate plugin code.
Instead sh scripts, you could be using python scripts or any other language that you are comfortable with and its available in the Terra environment.


## Creating a New Plugin from scratch

We are going to create a simple plugin that will clone a repository
from a git repository to a specified directory. We will make it as 
simple as possible. and very flexible so it can be used as a component
for other plugins.

### The `plugin` Directory

The `plugin` directory is where all your plugins will live. We use [pluginlib](https://github.com/Rockhopper-Technologies/pluginlib)
to manage our plugins and recursively load them. 

1. Create a new python file in the `plugin` directory
```bash
touch plugins/gitloader.py
```

### Setup Run Environment

When Terra runs a plugin, it is launched as a [Kubernetes Job](https://kubernetes.io/docs/concepts/workloads/controllers/job/).
That job will load your plugin and then execute it with [pytest](https://docs.pytest.org/).

> **Note:** Terra uses [pytest](https://docs.pytest.org/) to run your plugin
> also in production. We mainly do this because of how much extra information
> [pytest](https://docs.pytest.org/) provides for debugging purposes.

1. Create a new python file in the `tests` directory
```bash
touch tests/test_gitloader.py
```

### Writing the Plugin

Now that we have our plugin file, we can start writing our plugin.

```python linenums="1" title="plugins/gitloader.py" hl_lines="18-27"
--8<-- "plugins/gitloader.py:1:16"
```

#### Configuration

Plugins must define certain information about it to be picked up by Terra.

* `_alias_` - The name of the plugin
* `icon` - The icon to display in the UI. This should be a URL to an image.
* `description` - A short description of what the plugin does.
* `category` - The category the plugin belongs to. This is used to group plugins in the UI and also provides insight into what industry this plugin may be used for.
* `tags` - A list of tags that can be used to search for the plugin in the UI.
* `fields` - A list of fields that the plugin uses as input. This is used to generate the UI for the plugin and get input from the user.
    * `Plugin.field` - This is a data set that describes the input field
        * `Reference Name` - The name of the field which is used to parse from the frontend
        * `Display Name` - The name of the field which is displayed to the user
        * `required` - If the field is required

```python linenums="1" title="Configuration"
--8<-- "plugins/gitloader.py:18:27"
```

#### Preflight

Next we will add a `preflight` function which will validate the input from 
the user and ensure that the plugin can run successfully.

```python linenums="1" title="Preflight" 
--8<-- "plugins/gitloader.py:29:49"
```

#### Install

Lastly, we will add the `install` function which will execute the plugin.

```python linenums="1" title="Install"
--8<-- "plugins/gitloader.py:51:60"
```

#### Final Code

```python linenums="1" title="Final Plugin Code"
--8<-- "plugins/gitloader.py"
```

### Testing the Plugin

Now that we have written our plugin, we can test it.

> **Note:** TESTS ARE NOT OPTIONAL! You must write tests for your plugin to run.

#### Writing Test Runner

We will write a test runner that will run our plugin.

```python linenums="1" title="tests/test_gitloader.py"
--8<-- "tests/test_gitloader.py:1:11"
```

#### Loading our Plugin

We will load our plugin and then run it with the field values and `_alias_` we provided above.

```python linenums="1" title="Loading Plugin"
--8<-- "tests/test_gitloader.py:8"
```

> **Note:** This matches the exact same way the production environment will run your plugin.


#### Running the Test

Now that we have our entire environment setup, it is time to run the test.
We provide a `Makefile` target that will run the test for you. Then naming
convention for the run is `make dev-<test name>`. In our case, we called our
test `test_gitloader`, so `make` will target your test env and run it for you.

```bash
make dev-gitloader
```

This will do a few things in this order:

1. Launch a `kind` cluster
2. Use `skaffold` to build the runner container
3. `skaffold` will then deploy the `k8s` folder to the kind cluster
4. Using the `skaffold` verify configuration, it will run your plugin in the kind cluster as a job, just like it does in production.
5. The runner will then load your plugin and execute it in a `pytest` environment in full debug mode.
6. If everything is successful, you will see a `PASSED` message at the end of the output.

## Cleaning Up

Once you are done testing, you can clean up your environment by running the following command:

```bash
make down
```

## Congratulations!

You have written your first Terra plugin. You can now start building more complex plugins and contributing to the Terra 
ecosystem. Take a look at some more of our Official Juno Plugins to get an idea of what you can build.

## Next Steps

- [Software Installers](software_installers.md)
- [Extensions](extensions.md)
- [Service Installers](service_installers.md)
- [Bundles](bundles.md)
