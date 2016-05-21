class FileWriter

  def write_text(filename = ARGV[0], text)
    output_file = File.open(filename, 'w')
    output_file.write(text)
    output_file.close
  end
end
