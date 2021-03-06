require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/night_write'
require './lib/night_read'
require 'pry'

class EncoderTest < Minitest::Test

  HELLO_WORLD = "0.0.0.0.0......00.0.0.00..\n00.00.0..00...00.0000..000\n....0.0.0......00.0.0...0."
  EIGHTY_TWO_A = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
  ALL = "..............0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...0...0...00..\n..00..0...000...0....0.00.00000.00..0....0.00.00000.00..0.00...0.0......0.......\n..0.0...00.000....................0.0.0.0.0.0.0.0.0.0.0000.0000000.0...0...0...0\n00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0..0...0....0..\n.0...0..0...00..00..0...00......0........0...0..0...00..00..0...00......0...00..\n...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00..000.000.0.0.0\n00..00..0.\n.....0...0\n00.000.000"

  def setup
    @file_io = NightWrite.new
    @encoder = Encoder.new
  end

  def test_return_string
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/a.txt"))
    assert_instance_of String, encoding
  end

  def test_returns_a_in_braille
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/a.txt"))
    assert_equal "0.\n..\n..", encoding
  end

  def test_returns_capital_A_in_braille
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/capsA.txt"))
    assert_equal "..0.\n....\n.0..", encoding
  end

  def test_returns_two_braille_letters
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/ab.txt"))
    assert_equal "0.0.\n..0.\n....", encoding
  end

  def test_returns_two_uppercase_braille_letters
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/capsAB.txt"))
    assert_equal "..0...0.\n......0.\n.0...0..", encoding
  end

  def test_returns_hello_world_in_braille
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/hello_world.txt"))
    assert_equal "0.0.0.0.0......00.0.0.00..\n00.00.0..00...00.0000..000\n....0.0.0......00.0.0...0.", encoding
  end

  def test_80_char_to_braille
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/80a.txt"))
    assert_equal "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................", encoding
  end

  def test_82_char_to_braille
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/82a.txt"))
    assert_equal EIGHTY_TWO_A, encoding
  end

  def test_all_chars_to_braille
    encoding = @encoder.text_to_braille(@file_io.read("./test/support/all_text.txt"))
    assert_equal ALL, encoding
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
  def test_returns_an_english_string
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/a_braille.txt"))
    assert_instance_of String, encoding
  end

  def test_returns_capital_A
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/capsA_braille.txt"))
    assert_equal "A", encoding
  end

  def test_returns_a
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/a_braille.txt"))
    assert_equal "a", encoding
  end

  def test_returns_two_letters
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/ab_braille.txt"))
    assert_equal "ab", encoding
  end

  def test_returns_two_uppercase_letters
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/capsAB_braille.txt"))
    assert_equal "AB", encoding
  end

  def test_returns_hello_world_in_text
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/braillo_world.txt"))
    assert_equal "hello, world!", encoding
  end

  def test_80_char_to_text
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/80b.txt"))
    assert_equal "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", encoding
  end

  def test_82_char_to_text
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/82b.txt"))
    assert_equal "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", encoding
  end

  def test_all_chars_to_text
    encoding = @encoder.braille_to_text(@file_io.read("./test/support/all_braille.txt"))
    assert_equal " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", encoding
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
