class Encoder
  attr_reader :braille, :english, :alphabet, :numbers, :new_lines

  def initialize
    @braille = []
    @english = []
    @new_lines = []
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
      " " => ["..", "..", ".."], # "but" => ["0.", "0.", ".."]
      # "can" => ["00", "..", ".."], "do" => ["00", ".0", ".."],
      # "every" => ["0.", ".0", ".."], "from" => ["00", "0.", ".."],
      # "go" => ["00", "00", ".."], "have" => ["0.", "00", ".."],
      # "just" => [".0", "00", ".."], "knowledge" => ["0.", "..", "0."],
      # "like" => ["0.", "0.", "0."], "more" => ["00", "..", "0."],
      # "not" => ["00", ".0", "0."], "people" => ["00", "0.", "0."],
      # "quite" => ["00", "00", "0."], "rather" => ["0.", "00", "0."],
      # "so" => [".0", "0.", "0."], "that" => [".0", "00", "0."]
    }
    @numerals = {
      "1" => ["0.", "..", ".."], "2" => ["0.", "0.", ".."],
      "3" => ["00", "..", ".."], "4" => ["00", ".0", ".."],
      "5" => ["0.", ".0", ".."], "6" => ["00", "0.", ".."],
      "7" => ["00", "00", ".."], "8" => ["0.", "00", ".."],
      "9" => [".0", "0.", ".."], "0" => [".0", "00", ".."]
    }
  end

  def text_to_braille(string)
    string.chomp.chars.map do |char|

      braille << alphabet[:shift] unless char == char.downcase
      braille << alphabet[char.downcase]
    end

    #   number[char]
    # else
    # braille << alphabet[char]
    # end braille.insert(index[char] -1, alphabet["#"])
    last_braille = []
    braille.transpose.map { |ary| last_braille << ary.join }
    line_end(last_braille).join("\n")
  end

  def braille_to_text(string)
    braille = break_fix(string.split)
    binding.pry
    braille.map do |ary|
      ary.chars.each_slice(2).map(&:join)
    end
    braille = braille
    braille.each do |sym|
      english << alphabet.invert[sym]
    end
    find_shifts(english).join
  end

  def find_shifts(ary)
    ary.each_with_index do |char, index|
      if char == :shift
        ary.delete_at(index)
        ary[index] = ary[index].upcase
      end
    end
  end

  def line_end(array)
    x = array[0].length
    while x > 0
      array.map do |line|
        new_line = line.slice!(0..79)
        new_lines << new_line
      end
      x -= 80
    end
    new_lines
    # binding.pry
  end

  def break_fix(array) #needs fixed
    if array.count > 3
      array[0] = array[2].concat(array.last)
      array[1] = array[1].concat(array.last)
      array[0] = array[0].concat(array.last)
    end
  end
end
