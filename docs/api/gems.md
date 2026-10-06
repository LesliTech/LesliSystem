# Gem Discovery

`LesliSystem.gems` returns metadata for loaded utility gems in LesliSystem's known gem registry.

```ruby
LesliSystem.gems.each do |name, metadata|
  puts "#{name} #{metadata[:version]}"
end
```

The current registry recognizes:

* `LesliDate`
* `LesliView`
* `LesliAssets`
* `LesliSystem`

A package appears only when its Ruby constant is loaded and RubyGems can find its installed specification. This API is not a general inventory of every installed gem.

## Read Gem Metadata

```ruby
assets = LesliSystem.gems.fetch("LesliAssets", {})

assets[:version]
assets[:build]
assets[:summary]
assets[:description]
assets[:metadata]
assets[:dir]
```

Gem metadata uses the same schema as engine metadata. The `path` value is `nil` because utility gems do not expose a mounted Rails route.

Use `fetch` with a default, or another nil-safe lookup, when a gem may not be installed or loaded:

```ruby
version = LesliSystem.gems.dig("LesliDate", :version)
```

## Cache Behavior

The gem registry is memoized after its first call. Require optional gems before building the registry and restart the process after changing the dependency set.

Applications should not add entries directly to `LesliSystem::Engines::GEMS`. There is currently no public registration or refresh API; changes to the supported package registry belong in LesliSystem itself.
