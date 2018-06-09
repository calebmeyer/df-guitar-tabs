# encoding: UTF-8

TAB_TO_CONVERT = File.join(File.dirname(__FILE__), '../txt/song_game.txt')
lines = File.open(TAB_TO_CONVERT).read().split("\n")
song = []

lines = lines.select { |line| line.include?('|-') }.map(&:chars)

lines.each_slice(6) do |row|
  loop do
    break if row[0].length.zero?
    notes = {
      hi_e: row[0].pop,
      b: row[1].pop,
      g: row[2].pop,
      d: row[3].pop,
      a: row[4].pop,
      e: row[5].pop,
    }

    notes = notes.select { |note, value| Integer(value, 10) rescue false }

    song.push(notes) unless notes == {}
  end
end
puts song
