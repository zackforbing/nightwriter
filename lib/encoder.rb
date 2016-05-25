class Encoder
  attr_reader :braille, :english, :alphabet, :numbers

  def initialize
    @braille = []
    @english = []
    @alphabet = {
      "a" => ["0.", "..", ".."], "b" => ["0.", "0.", ".."],
      "c" => ["00", "..", ".."], "d" => ["00", ".0", ".."],
      "e" => ["0.", ".0", ".."], "f" => ["00", "0.", ".."],
      "g" => ["00", "00", ".."], "h" => ["0.", "00", ".."],
      "i" => [".0", "0.", ".."], "j" => [".0", "00", ".."],
      "k" => ["0.", "..", "0."], "l" => ["0.", "0.", "0."],
      "m" => ["00", "..", "0."], "n" => ["00", ".0", "0."],
      "o" => ["0.", ".0", "0."], "p" => ["00", "0.", "0."],
      "q" => ["00", "00", "0."], "r" => ["0.", "00", "0."],
      "s" => [".0", "0.", "0."], "t" => [".0", "00", "0."],
      "u" => ["0.", "..", "00"], "v" => ["0.", "0.", "00"],
      "w" => [".0", "00", ".0"], "x" => ["00", "..", "00"],
      "y" => ["00", ".0", "00"], "z" => ["0.", ".0", "00"],
      "!" => ["..", "00", "0."], "'" => ["..", "..", "0."],
      "," => ["..", "0.", ".."], "-" => ["..", "..", "00"],
      "." => ["..", "00", ".0"], "?" => ["..", "0.", "00"],
      :shift => ["..", "..", ".0"], "#" => [".0", ".0", "00"],
      " " => ["..", "..", ".."], # "but" => ["0.", "0.", ".."], "can" => ["00", "..", ".."],
      # "do" => ["00", ".0", ".."], "every" => ["0.", ".0", ".."],
      # "from" => ["00", "0.", ".."], "go" => ["00", "00", ".."],
      # "have" => ["0.", "00", ".."], "just" => [".0", "00", ".."],
      # "knowledge" => ["0.", "..", "0."], "like" => ["0.", "0.", "0."],
      # "more" => ["00", "..", "0."], "not" => ["00", ".0", "0."],
      # "people" => ["00", "0.", "0."], "quite" => ["00", "00", "0."],
      # "rather" => ["0.", "00", "0."], "so" => [".0", "0.", "0."],
      # "that" => [".0", "00", "0."]
    }
    @numbers = {
      "1" => ["0.", "..", ".."], "2" => ["0.", "0.", ".."],
      "3" => ["00", "..", ".."], "4" => ["00", ".0", ".."],
      "5" => ["0.", ".0", ".."], "6" => ["00", "0.", ".."],
      "7" => ["00", "00", ".."], "8" => ["0.", "00", ".."],
      "9" => [".0", "0.", ".."], "0" => [".0", "00", ".."]
    }
  end

  def text_to_braille(string)
    string.strip.chars.map { |char| braille << alphabet[char]}
    # if numbers.keys.include?(char)
    #   number[char]
    # else
    # braille << alphabet[char]
    # end braille.insert(index[char] -1, alphabet["#"])
    braille.transpose.each { |array| array << "\n" }.join
  end

  def braille_to_text(string)
    braille = string.split.map do
      |ary| ary.chars.each_slice(2).map(&:join)
    end
    braille.transpose.map { |sym| english << alphabet.invert[sym]}
    english.join
  end
  # private
  #
  # def find_capitals(string)
  #   string.chars.find_all do |thing|
  #     #code that finds capitals
  #     #more things that makes them lowercase with a shift in front
  #     "B"
  #     array << :SHIFT
  #     array << thing.lowercase
  #   end
  # end
end
