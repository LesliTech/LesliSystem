# Engine Discovery

LesliSystem discovers loaded Rails engines from its known engine registry and adds metadata for the host application.

## List Engines

```ruby
engines = LesliSystem.engines
```

The result is keyed by Ruby namespace:

```ruby
engines.each do |name, metadata|
  puts "#{name}: #{metadata[:version]} at #{metadata[:path]}"
end
```

Only known engine constants that are loaded when the registry is built are included. The synthetic `Root` entry is always present:

```ruby
LesliSystem.engines.fetch("Root")
# {
#   code: "root",
#   name: "Root",
#   path: "/",
#   version: "1.0.0",
#   summary: "",
#   description: "",
#   metadata: [],
#   build: "0000000",
#   dir: Rails.root.to_s
# }
```

## Find One Engine

Pass a string or symbol to `LesliSystem.engine`:

```ruby
LesliSystem.engine("LesliSupport")
LesliSystem.engine(:lesli_support)
```

Names are converted with Active Support's `camelize`, so both examples resolve the `LesliSupport` registry entry.

Pass a second argument to return one property:

```ruby
LesliSystem.engine("LesliSupport", :path)
LesliSystem.engine("LesliSupport", "version")
```

The property may be a string or symbol. An unknown property returns `nil` when the engine exists.

## Missing Engines

A name that is not in LesliSystem's known engine list resolves to the synthetic `Root` entry:

```ruby
LesliSystem.engine("CustomApplication") == LesliSystem.engine("Root")
# true
```

A known engine whose constant was not loaded is absent from the registry. Requesting its complete metadata returns `nil`; requesting a property directly is not safe in that case. Check the complete result first:

```ruby
engine = LesliSystem.engine("LesliCalendar")
path = engine[:path] if engine
```

## Mounted Paths

For each loaded engine, LesliSystem asks its Rails engine routes for the current script name. The resulting `path` reflects the mount known when the registry is first built.

Because the registry is memoized, load and mount engines before the first call. Restart the process after changing routes or installed engines.
