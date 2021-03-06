require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/night_write'

class NightWriteTest < Minitest::Test
  attr_reader :file_io

  def setup
    @file_io = NightWrite.new
  end

  def test_reader_can_read
    assert_equal "test", @file_io.read("./test/support/test.txt")
  end

  def test_reader_reads_braille
    assert_equal "0.\n..\n..", @file_io.read("./test/support/braille_test.txt")
  end

  def test_writer_can_write
    @file_io.write_text("./test/support/test_write.txt", "test")
    assert_equal "test", @file_io.read("./test/support/test_write.txt")
  end

  def test_writer_writes_braille
    @file_io.write_text("./test/support/braille_test_write.txt", "0.\n..\n..\n")
        assert_equal "0.\n..\n..", @file_io.read("./test/support/braille_test_write.txt")
  end

  def test_writer_writes_from_reader_file
    @file_io.write_text("test_write.txt", @file_io.read("./test/support/test.txt"))
    assert_equal "test", @file_io.read("./test/support/test_write.txt")
  end
end
