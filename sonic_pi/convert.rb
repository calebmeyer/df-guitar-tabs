# encoding: UTF-8

TAB_TO_CONVERT = File.join(File.dirname(__FILE__), '../txt/song_game.txt')
GUITAR_NOTES = {
  hi_e: %i(e4 f4 fs4 g4 gs4 a4 as4 b4 c5 cs5 d5 ds5 e5),
  b:    %i(b3 c4 cs4 d4 ds4 e4 f4 fs4 g4 gs4 a4 as4 b4),
  g:    %i(g3 gs3 a3 as3 b3 c4 cs4 d4 ds4 e4 f4 fs4 g4),
  d:    %i(d3 e3 f3 fs3 g3 gs3 a3 as3 b3 c4 cs4 d4),
  a:    %i(a2 as2 b2 c3 cs3 d3 e3 f3 fs3 g3 gs3 a3),
  e:    %i(e2 f2 fs2 g2 gs2 a2 as2 b2 c3 cs3 d3 e3),
}
lines = File.open(TAB_TO_CONVERT).read().split("\n")
song = []
code = ['use_synth :pluck', 'use_bpm 160']

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

song.each do |chord|
  chord.each do |string, value|
    code.push("play :#{GUITAR_NOTES[string.to_sym][value.to_i]}, release: 1")
  end
  code.push("sleep 1\n")
end
File.open(File.join(File.dirname(__FILE__), './sonic_pi.rb'), 'w') do |file|
  file.write(code.join("\n"))
end
