require './lib/night_write'

class NightRead < NightWrite

  def encode(filename = ARGV[0])
    braille = read(filename).chomp
    encoder = Encoder.new
    message = encoder.braille_to_text(braille)
    write_text(ARGV[1], message)
    puts "Created '#{ARGV[1].split("/").last}' containing #{message.length} characters"
  end
end

if __FILE__ == $PROGRAM_NAME
  file = NightRead.new
  file.encode
end
