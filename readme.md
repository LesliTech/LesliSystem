<div align="center">
    <h1 align="center">
        <img width="100" alt="LesliSystem" src="./docs/images/system-logo.svg" />
    </h1>
    <h3 align="center">Core system utilities for the Lesli Framework.</h3>
</div>

<br />

<div align="center">
    <a target="_blank" href="https://github.com/LesliTech/LesliSystem/actions/workflows/main.yml">
        <img alt="LesliSystem test status" src="https://img.shields.io/github/actions/workflow/status/LesliTech/LesliSystem/main.yml?branch=main&style=for-the-badge&logo=github&label=tests">
    </a>
    <a target="_blank" href="https://rubygems.org/gems/lesli_system">
        <img alt="Gem Version" src="https://img.shields.io/gem/v/lesli_system?style=for-the-badge&logo=ruby">
    </a>
    <a target="_blank" href="https://codecov.io/github/LesliTech/LesliSystem">
        <img alt="Codecov" src="https://img.shields.io/codecov/c/github/LesliTech/LesliSystem?style=for-the-badge&logo=codecov">
    </a>
    <a target="_blank" href="https://sonarcloud.io/project/overview?id=LesliTech_LesliSystem">
        <img alt="Sonar Quality Gate" src="https://img.shields.io/sonar/quality_gate/LesliTech_LesliSystem?server=https%3A%2F%2Fsonarcloud.io&style=for-the-badge&logo=sonarqubecloud&label=Quality">
    </a>
</div>

<br />

---

<br />

## Introduction

LesliSystem provides shared system-level utilities for applications built with the [Lesli Framework](https://github.com/LesliTech/Lesli).

It exposes installed engine and gem metadata and provides helpers for resolving engine-specific models from application objects.

<br />

## Features

- Installed engine discovery
- Engine metadata and version introspection
- Installed Lesli gem discovery
- Lookup by engine name or code
- Engine-specific model resolution
- Shared system utilities for the Lesli ecosystem

<br />

## Installation

Add LesliSystem to the application:

```shell
bundle add lesli_system
```

<br />

## Usage

### Inspect installed engines

```ruby
LesliSystem.engines
LesliSystem.engine("Lesli")
LesliSystem.engine(:lesli)
LesliSystem.engine("Lesli", "path")
```

Engine metadata includes its code, name, route path, version, build, description, and installation directory when available.

List the installed Lesli gems:

```ruby
LesliSystem.gems
```

### Resolve engine models

`LesliSystem::Klass` derives the engine namespace from an object or accepts it explicitly:

```ruby
builder = LesliSystem::Klass.new(self)

builder.engine_name
builder.model.account
builder.model.dashboard
```

```ruby
builder = LesliSystem::Klass.new(engine: "LesliBell")
builder.model.dashboard
```

<br />

## Development

Clone the repository and install its dependencies:

```shell
git clone https://github.com/LesliTech/LesliSystem.git
cd LesliSystem
bundle install
```

To use local source from a Lesli development workspace, reference it from the host application's `Gemfile`:

```ruby
gem "lesli_system", path: "gems/LesliSystem"
```

### Tests

Run the default test task from the LesliSystem directory:

```shell
bundle exec rake
```

<br />

## Documentation

- [Lesli website](https://www.lesli.dev/)
- [Documentation](https://www.lesli.dev/gems/system/)
- [Release notes](https://github.com/LesliTech/LesliSystem/releases)
- [Issue tracker](https://github.com/LesliTech/LesliSystem/issues)
- [Source code](https://github.com/LesliTech/LesliSystem)

<br />

## Community

- [X: @LesliTech](https://x.com/LesliTech)
- [hello@lesli.tech](mailto:hello@lesli.tech)
- [https://www.lesli.tech](https://www.lesli.tech)

<br />

## License

Copyright (c) 2026, Lesli Technologies, S. A.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).

The complete license text is available in the [license file](./license).

---

<br />
<br />

<div align="center">
    <img width="80" alt="Lesli icon" src="https://cdn.lesli.tech/lesli/brand/app-icon.svg" />
    <h3 align="center">The Open-Source SaaS Development Framework for Ruby on Rails.</h3>
</div>
