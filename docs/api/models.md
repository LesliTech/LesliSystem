# Model Resolution

`LesliSystem::Klass` resolves the conventional `Account` and `Dashboard` model constants for a Lesli engine namespace.

## Resolve from an Object

Pass a namespaced object to derive the first segment of its class name:

```ruby
resolver = LesliSystem::Klass.new(self)

resolver.engine_name
resolver.model.account
resolver.model.dashboard
```

For an instance of `LesliSupport::TicketsController`, `engine_name` becomes `LesliSupport`. Pass an instance, not a class object; passing `LesliSupport::TicketsController` would derive `Class` from the object's own class.

## Resolve an Explicit Namespace

Use the `engine` keyword when the namespace is already known:

```ruby
resolver = LesliSystem::Klass.new(engine: "LesliSupport")

resolver.engine_name
# "LesliSupport"

resolver.model.account
# LesliSupport::Account

resolver.model.dashboard
# LesliSupport::Dashboard
```

The explicit name must be the Ruby namespace, not the snake-case gem name.

## Return Values

`model` is a struct with two readers:

| Reader | Constant resolved |
| --- | --- |
| `model.account` | `<Engine>::Account` |
| `model.dashboard` | `<Engine>::Dashboard` |

Resolution uses Active Support's `safe_constantize`. A missing or unloaded model returns `nil` instead of raising a constant lookup error:

```ruby
resolver = LesliSystem::Klass.new(engine: "LesliDate")
resolver.model.account
# nil
```

Check the returned constant before invoking model methods. LesliSystem does not autoload, define, or validate the resolved models and does not resolve arbitrary model names.
