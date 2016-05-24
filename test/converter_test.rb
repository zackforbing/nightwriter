require 'minitest/autorun'
require 'minitest/nyan_cat'
require_relative '../lib/file_io'
require_relative '../lib/converter'
require_relative '../braille_array'

class ConverterTest < Minitest::Test

  def setup
    @file_1 = FileIO.new
    @converter = Converter.new
  end

  def test_converter_returns_an_array
    skip
    assert_instance_of Array, @converter.create_braille(@file_1.read("../txt/a.txt"))
  end

  def test_converter_returns_an_array_of_strings
    skip
    assert_instance_of String, @converter.create_braille(@file_1.read("../txt/a.txt"))[0]
  end

  def test_map_top_line_of_character
  assert_equal "0.",  @converter.create_top_line(@file_1.read("../txt/a.txt"))
  end

  def test_map_middle_line_of_character
  assert_equal "..",  @converter.create_middle_line(@file_1.read("../txt/a.txt"))
  end
end
