require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/night_write'
require './lib/night_read'
require 'pry'

class EncoderTest < Minitest::Test

  HELLO_WORLD = "0.0.0.0.0......00.0.0.00..\n00.00.0..00...00.0000..000\n....0.0.0......00.0.0...0.\n"

  def setup
    @file_io = NightWrite.new
    @encoder = Encoder.new
  end
  #night_write
  def test_returns_an_array
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/a.txt"))
    assert_instance_of String, encoding
  end

  def test_returns_an_array_of_strings
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/a.txt"))
    assert_instance_of String, encoding[0][0][0]
  end

  def test_returns_hash_value_of_a
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/a.txt"))
    assert ["0.", "..", ".."], encoding[0][0]
  end

  def test_returns_two_braille_letters
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/ab.txt"))
    assert [["0.", "..", ".."],["0.", "0.", ".."]], encoding
  end

  def test_returns_hello_world_in_array
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/hello_world.txt"))
    assert [["0.", "00", ".."],["0.", ".0", ".."],["0.", "0.", "0."],
    ["0.", "0.", "0."],["0.", ".0", "0."],["..", "..", ".."],[".0", "00", ".0"],
    ["0.", ".0", "0."],["0.", "00", "0."],["0.", "0.", "0."],["00", ".0", ".."],
    ["..", "00", "0."]], encoding
  end

  def test_prints_braille_to_file
    ARGV[0] = File.join(Dir.pwd, "./test/support/hello_world.txt")
    output_file = File.join(Dir.pwd, "./test/support/braille.txt")
    ARGV[1] = output_file
    file_io = NightWrite.new
    file_io.encode
    assert_equal HELLO_WORLD, File.read(output_file)
  end
  #night_read
  def test_returns_an_array
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/a.txt"))
    assert_instance_of String, encoding
  end

  def test_returns_an_array_of_strings
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/a.txt"))
    assert_instance_of String, encoding[0][0][0]
  end

  def test_returns_hash_value_of_a
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/a.txt"))
    assert ["0.", "..", ".."], encoding[0][0]
  end

  def test_returns_two_braille_letters
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/ab.txt"))
    assert [["0.", "..", ".."],["0.", "0.", ".."]], encoding
  end

  def test_returns_hello_world_in_array
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/hello_world.txt"))
    assert [["0.", "00", ".."],["0.", ".0", ".."],["0.", "0.", "0."],
    ["0.", "0.", "0."],["0.", ".0", "0."],["..", "..", ".."],[".0", "00", ".0"],
    ["0.", ".0", "0."],["0.", "00", "0."],["0.", "0.", "0."],["00", ".0", ".."],
    ["..", "00", "0."]], encoding
  end

  def test_prints_text_to_file
    ARGV[0] = File.join(Dir.pwd, "./test/support/braillo_world.txt")
    output_file = File.join(Dir.pwd, "./test/support/text.txt")
    ARGV[1] = output_file
    file_io = NightRead.new
    file_io.encode
    assert_equal "hello, world!", File.read(output_file)
  end
end
