require "./lib/encoder"
class NightWrite
  attr_reader :read, :write_text

  def read (filename = ARGV[0])
    File.read(filename)
  end

  def write_text(filename = ARGV[1], text)
    output_file = File.open(filename, 'w')
    output_file.write(text)
    output_file.close
  end

  def encode(filename = ARGV[0])
    text = read(filename)
    encoder = Encoder.new
    message = encoder.text_to_braille(text)
    write_text(ARGV[1], message)
    puts "Created '#{ARGV[1].split("/").last}' containing #{message.length} characters"
  end
end
