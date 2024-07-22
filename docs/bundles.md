# <center>Writing Bundles</center>

Bundles are a way to provide multiple plugins in a single package. 
This is useful when you have a set of plugins that are related to 
each other or want to provide a set of Plugins that represent a larger 
install. For example, you may have a set of plugins that all install 
software that is used for video editing or software development. You 
can then offer it as a single bundle that can be installed with a 
single run instead of multiple.

## Prerequisites

- [Read Getting Started](getting_started.md)

## Creating a Juno Pipeline Bundle

[Juno Innovations](https://junovfx.com) provides a default pipeline that it
uses for its own projects. This pipeline is offered as a bundle for others to 
install and use. We will walk through how this is created.

### The `plugin` Directory

* Create a new python file in the `plugin` directory
```bash
touch plugins/juno_pipline.py
```

### Setup Run Environment

* Create a new python file in the `tests` directory
```bash
touch tests/test_juno_pipeline.py
```

### Writing the Plugin

Now that we have our plugin file, we can start writing our plugin.

```python linenums="1" title="plugins/juno_pipeline.py" hl_lines="18-27"
--8<-- "plugins/juno_pipeline.py:1:16"
```

#### Configuration

```python linenums="1" title="Configuration"
--8<-- "plugins/juno_pipeline.py:18:22"
```

#### Preflight

Next we will add a `preflight` function which will validate the input from
the user and ensure that the plugin can run successfully.

```python linenums="1" title="Preflight" 
--8<-- "plugins/juno_pipeline.py:24:36"
```

#### Install

Lastly, we will add the `install` function which will execute the plugin.

##### Calling Other Plugins

Because the Juno Pipeline is a bundle, it will call other plugins to install the software it needs.
This is done by calling the `plugins()` function that is provided by the `terra` loaders.
This allows Juno to load the Blender or Nuke plugins and install them as needed.

This can then be chained together and all versions of the software can be locked by Juno for
better support.

```python linenums="1" title="Install"
--8<-- "plugins/juno_pipeline.py:38"
```

#### Final Code

```python linenums="1" title="Final Plugin Code"
--8<-- "plugins/juno_pipeline.py"
```

### Testing the Plugin

Now that we have written our plugin, we can test it.

> **Note:** TESTS ARE NOT OPTIONAL! You must write tests for your plugin to run.

#### Writing Test Runner

We will write a test runner that will run our plugin.

```python linenums="1" title="tests/test_juno_pipeline.py"
--8<-- "tests/test_juno_pipeline.py:1:10"
```

#### Loading our Plugin

We will load our plugin and then run it with the field values and `_alias_` we provided above.

```python linenums="1" title="Loading Plugin"
--8<-- "tests/test_juno_pipeline.py:11"
```

#### Running the Test

```bash
make dev-juno_pipeline
```

We can then check the install with the following command from the root of the repository.

```bash
ls -la .apps/
```

## Conclusion

You have now created a simple Bundle which can be used to install multiple plugins at once.
This gives you a ton of flexibility in how you can install software on your Orion cluster.
