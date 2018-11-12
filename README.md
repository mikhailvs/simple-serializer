# SimpleEventBus

## Usage
Use the `SimpleEventBus` class as a singleton, or instantiate new instances of it.

```ruby
SimpleEventBus.subscribe(:event_happened) do |params|
  puts "Event handled with block: #{params.inspect}"
end

class EventHandler
  def event_happened(params)
    puts "Event handled with method: #{params.inspect}"
  end
end

SimpleEventBus.emit(:event_happened, param1: 'hello', param2: 'world')

bus = SimpleEventBus.new

bus.subscribe(:event_happened, EventHandler.new, once: true)

bus.emit(:event_happened, request: 'handle THIS')
```
