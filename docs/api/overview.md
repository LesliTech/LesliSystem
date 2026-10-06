# API Overview

LesliSystem exposes a small facade for inspecting known Lesli engines and gems and for resolving conventional engine models. Applications should call the methods on `LesliSystem` rather than reading the mutable registry constants in `LesliSystem::Engines` directly.

## Public Entry Points

| Entry point | Result |
| --- | --- |
| `LesliSystem.engines` | Metadata hash for loaded, known Rails engines plus the host application |
| `LesliSystem.engine(name)` | Metadata for one known engine |
| `LesliSystem.engine(name, property)` | One metadata property for a known engine |
| `LesliSystem.gems` | Metadata hash for loaded, known Lesli utility gems |
| `LesliSystem::Klass.new(...)` | Resolver for conventional engine model constants |
| `LesliSystem::VERSION` | Released gem version |
| `LesliSystem::BUILD` | Lesli build identifier |

## Package Metadata

Engine and gem registries use package constant names as keys and return the same metadata shape:

| Key | Type | Description |
| --- | --- | --- |
| `code` | String | Snake-case package code, such as `lesli_support` |
| `name` | String | Ruby namespace, such as `LesliSupport` |
| `path` | String or `nil` | Mounted route path for an engine; utility gems use `nil` |
| `version` | String | Package `VERSION` constant |
| `build` | String | Package `BUILD` constant |
| `summary` | String | Summary from the installed gemspec |
| `description` | String | Description from the installed gemspec |
| `metadata` | Hash; Array for `Root` | RubyGems metadata from the installed gemspec; the synthetic host entry currently uses an empty array |
| `dir` | String | Installed gem directory |

Treat returned registries and metadata as read-only. They are memoized and the current API returns the stored hash rather than a defensive copy.

## Registry Boundaries

Discovery is intentionally limited to package names listed by LesliSystem. A gem being present in `Gem::Specification` is not sufficient: its name must be in the corresponding registry and its Ruby constant must already be loaded.

`LesliSystem.engines` additionally provides a synthetic `Root` package for the host application. It uses `/` as its path, `Rails.root` as its directory, and fixed placeholder version and build values.

The registries are built once per process. Restart the Rails server, console, job worker, or task after changing the installed or loaded package set.

See [Engines](/gems/system/api/engines), [Gems](/gems/system/api/gems), and [Model Resolution](/gems/system/api/models) for detailed examples.
