#!/usr/bin/env ruby

require "fileutils"

require_relative "life_event"
require_relative "event_router"
require_relative "handlers/console_handler"
require_relative "handlers/file_handler"
require_relative "handlers/sqlite_handler"

DATA_DIR = File.expand_path("data", __dir__)

router = EventRouter.new([
  ConsoleHandler.new,
  FileHandler.new(File.join(DATA_DIR, "lifetrack.log")),
  SqliteHandler.new(File.join(DATA_DIR, "lifetrack.db"))
])

EVENT_PROMPTS = {
  "1" => "work session",
  "2" => "study session",
  "3" => "exercise session",
  "4" => "meal"
}.freeze

def show_menu
  puts "\n=== LifeTrack ==="
  puts "1. Log a work session"
  puts "2. Log a study session"
  puts "3. Log an exercise session"
  puts "4. Log a meal"
  puts "5. Exit"
  print "\nChoose an option: "
end

def log_event(router, choice)
  event_type = LifeEvent::EVENT_TYPES[choice]
  return unless event_type

  print "Description: "
  description = gets.chomp
  print "Duration (minutes): "
  duration = gets.chomp.to_i

  event = LifeEvent.new(
    type: event_type,
    description: description,
    duration_minutes: duration
  )

  router.dispatch(event)
  puts "✓ Event logged."
end

loop do
  show_menu
  choice = gets.chomp

  case choice
  when "1", "2", "3", "4"
    log_event(router, choice)
  when "5"
    puts "Goodbye!"
    break
  else
    puts "Invalid option. Please choose 1–5."
  end
end
