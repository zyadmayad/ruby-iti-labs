# Pure data object — carries event facts, no I/O or formatting logic.
class LifeEvent
  attr_reader :type, :description, :duration_minutes, :timestamp

  EVENT_TYPES = {
    "1" => :work,
    "2" => :study,
    "3" => :exercise,
    "4" => :meal
  }.freeze

  def initialize(type:, description:, duration_minutes:)
    @type = type
    @description = description
    @duration_minutes = duration_minutes
    @timestamp = Time.now
  end

  def type_label
    type.to_s.upcase
  end
end
