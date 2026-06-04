require_relative "handler"

# Observer: notifies every registered handler when an event fires.
# Depends only on Handler abstraction (Dependency Inversion).
class EventRouter
  def initialize(handlers = [])
    @handlers = handlers
  end

  def register(handler)
    @handlers << handler
  end

  def dispatch(event)
    @handlers.each { |handler| handler.handle(event) }
  end
end
