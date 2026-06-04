# Shared interface — exactly one method (Interface Segregation).
class Handler
  def handle(_event)
    raise NotImplementedError, "#{self.class} must implement #handle"
  end
end
