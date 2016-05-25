require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/encoder'
require './lib/night_write'
require 'pry'

class EncoderTest < Minitest::Test

  BRAILLE_TEXT = "0.0.0.0.0......00.0.0.00..\n00.00.0..00...00.0000..000\n....0.0.0......00.0.0...0.\n"

  def setup
    @file_io = NightWrite.new
    @encoder = Encoder.new
  end

  def test_returns_an_array
    # skip
    encoding = @encoder.text_to_braille(@file_io.read("./txt/a.txt"))
    assert_instance_of String, encoding
  end

  def test_returns_an_array_of_strings
    # skip
    encoding = @encoder.text_to_braille(@file_io.read("./txt/a.txt"))
    assert_instance_of String, encoding[0][0][0]
  end

  def test_returns_hash_value_of_a
    # skip
    encoding = @encoder.text_to_braille(@file_io.read("./txt/a.txt"))
    assert ["0.", "..", ".."], encoding[0][0]
  end

  def test_returns_two_braille_letters
    # skip
    encoding = @encoder.text_to_braille(@file_io.read("./txt/ab.txt"))
    assert [["0.", "..", ".."],["0.", "0.", ".."]], encoding
  end

  def test_returns_hello_world
    # skip
    encoding = @encoder.text_to_braille(@file_io.read("./txt/hello world.txt"))
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
    assert_equal BRAILLE_TEXT, File.read(output_file)
    #assert that the braille file is encoded as expected.
  end
end
