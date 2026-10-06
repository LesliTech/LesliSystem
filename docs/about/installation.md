# Installation

LesliSystem provides the package registry and namespace-resolution utilities used by the Lesli Framework. It is designed to run inside a Rails application where Rails and Active Support are already loaded.

## Requirements

The current repository test workflow uses Ruby 3.2.5, and its development bundle resolves Rails 8.0.2. The gemspec does not declare a Ruby version or runtime dependency constraint; applications should normally use the LesliSystem version selected by their installed Lesli release.

LesliSystem relies on:

* `Rails.root`
* Active Support inflections such as `camelize`, `constantize`, and `safe_constantize`
* Loaded Lesli package constants
* RubyGems specifications for installed packages

It is not intended to be a standalone Ruby package registry outside Rails.

## Install with Lesli

The main `lesli` gem installs and requires LesliSystem. A standard Lesli application does not need another initializer or explicit require.

## Install in Another Rails Application

Add the gem to the application:

```shell
bundle add lesli_system
```

Require it during application boot if Bundler is not configured to require it automatically:

```ruby
require "lesli_system"
```

LesliSystem does not add routes, migrations, database tables, environment variables, or generators.

## Verify the Installation

The registry always adds a synthetic `Root` entry for the host Rails application:

```shell
bin/rails runner 'puts LesliSystem.engine("Root", :path)'
```

The command should print:

```text
/
```

Inspect the loaded engine names with:

```shell
bin/rails runner 'puts LesliSystem.engines.keys'
```

## Package Discovery

When an engine or gem registry is first requested, LesliSystem:

1. Iterates through its known Lesli package names.
2. Keeps packages whose Ruby constants are currently loaded.
3. reads their installed gemspec, version, and build metadata.
4. Resolves the mounted route path for Rails engines.
5. Memoizes the resulting registry for the life of the process.

Load required packages before the first registry call. A package loaded afterward will not appear until the process restarts because there is currently no public cache-reset API.

Continue with the [API overview](/gems/system/api) and [engine discovery guide](/gems/system/api/engines).
