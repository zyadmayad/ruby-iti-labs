require "fileutils"
require "sqlite3"
require "time"
require_relative "../handler"

class SqliteHandler < Handler
  def initialize(db_path)
    @db_path = db_path
    FileUtils.mkdir_p(File.dirname(@db_path))
    @db = SQLite3::Database.new(@db_path)
    setup_schema
    show_previous_sessions
  end

  def handle(event)
    @db.execute(
      "INSERT INTO events (event_type, description, duration_minutes, logged_at) VALUES (?, ?, ?, ?)",
      [event.type.to_s, event.description, event.duration_minutes, event.timestamp.iso8601]
    )
  end

  private

  def setup_schema
    @db.execute <<~SQL
      CREATE TABLE IF NOT EXISTS events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        event_type TEXT NOT NULL,
        description TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        logged_at TEXT NOT NULL
      )
    SQL
  end

  def show_previous_sessions
    rows = @db.execute(
      "SELECT event_type, description, duration_minutes, logged_at FROM events ORDER BY logged_at DESC LIMIT 5"
    )
    return if rows.empty?

    puts "\n--- Previous sessions (from SQLite) ---"
    rows.each do |event_type, description, duration_minutes, logged_at|
      timestamp = Time.parse(logged_at).strftime("%Y-%m-%d %H:%M")
      puts "[#{timestamp}] #{event_type.upcase} — #{description} (#{duration_minutes} min)"
    end
    puts "---\n"
  end
end
