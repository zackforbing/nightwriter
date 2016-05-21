require 'minitest/autorun'
require 'minitest/nyan_cat'
require_relative '../lib/file_reader'
require_relative '../lib/file_writer'

class NightWriterTest < Minitest::Test

  def test_reader_can_read
    file_reader = FileReader.new
    assert_equal "test\n", file_reader.read("test.txt")
  end

  def test_writer_can_write
    file_writer = FileWriter.new
    file_reader = FileReader.new
    file_writer.write_text("test_write.txt", "test")
    assert_equal "test", file_reader.read("test_write.txt")
  end

  def test_reader_reads_braille
    file_reader = FileReader.new
    assert_equal "0.\n..\n..\n", file_reader.read("braille_test.txt")
  end

  def test_writer_writes_braille
    file_writer = FileWriter.new
    file_reader = FileReader.new
    file_writer.write_text("braille_test_write.txt", "0.\n..\n..\n")
        assert_equal "0.\n..\n..\n", file_reader.read("braille_test_write.txt")
  end

  def test_writer_writes_from_reader_file
    file_writer = FileWriter.new
    file_reader = FileReader.new
    file_writer.write_text("test_write.txt", file_reader.read("test.txt"))
    assert_equal "test", file_reader.read("test_write.txt")
  end
end
