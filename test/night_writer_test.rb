require 'minitest/autorun'
require 'minitest/nyan_cat'
require_relative '../lib/night_writer'
require 'pry'

class NightWriterTest < Minitest::Test

  def setup
    @file_1 = FileIO.new
    @nw = NightWriter.new
  end

  def test_returns_an_array
    # skip
    encoding = @nw.encode_file_to_braille(@file_1.read("../txt/a.txt"))
    assert_instance_of Array, encoding
  end

  def test_returns_an_array_of_strings
    encoding = @nw.encode_file_to_braille(@file_1.read("../txt/a.txt"))
    assert_instance_of String, encoding[0][0][0]
  end

  def test_returns_hash_value_of_a
    encoding = @nw.encode_file_to_braille(@file_1.read("../txt/a.txt"))
    assert ["0.", "..", ".."], encoding[0][0]
  end

  def test_returns_two_braille_letters
    encoding = @nw.encode_file_to_braille(@file_1.read("../txt/a.txt"))
    assert ["0.", "..", ".."], encoding[0]
  end
end
