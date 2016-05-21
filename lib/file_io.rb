class FileIO
  def read (filename = ARGV[0])
    File.read(filename)
  end

  def write_text(filename = ARGV[0], text)
    output_file = File.open(filename, 'w')
    output_file.write(text)
    output_file.close
  end
end
