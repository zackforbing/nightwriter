class FileIO
  attr_reader :read, :write_text

  def read (filename = ARGV[0])
    File.read(filename)
  end

  def write_text(filename = ARGV[1], text)
    output_file = File.open(filename, 'w')
    output_file.write(text)
    output_file.close
  end
end
