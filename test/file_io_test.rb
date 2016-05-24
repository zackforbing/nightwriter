require 'minitest/autorun'
require 'minitest/nyan_cat'
require_relative '../lib/file_io'

class FileIOTest < Minitest::Test
  attr_reader :file_io

  def setup
    @file_io = FileIO.new
  end

  def test_reader_can_read
    assert_equal "test\n", @file_io.read("test.txt")
  end

  def test_reader_reads_braille
    assert_equal "0.\n..\n..\n", @file_io.read("braille_test.txt")
  end

  def test_writer_can_write
    @file_io = FileIO.new
    @file_io.write_text("test_write.txt", "test")
    assert_equal "test", @file_io.read("test_write.txt")
  end

  def test_writer_writes_braille
    @file_io.write_text("braille_test_write.txt", "0.\n..\n..\n")
        assert_equal "0.\n..\n..\n", @file_io.read("braille_test_write.txt")
  end

  def test_writer_writes_from_reader_file
    @file_io.write_text("test_write.txt", @file_io.read("test.txt"))
    assert_equal "test\n", @file_io.read("test_write.txt")
  end
end
