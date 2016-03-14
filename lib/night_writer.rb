require_relative 'letter'
require 'pry'

class NightWriter

  def initialize
    @letter_map = Letter.new
  end

  def english_letter_translate(char)
      @letter_map.english_to_braille[char.downcase]
  end

  def is_upcase?(letter)
    symbols = [" ", "!", "'", "-", ".", ",", "?", "#", "&",
              "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    letter == letter.upcase && !symbols.include?(letter)
  end

  def is_number?(number)
    ("0".."9").to_a.include?(number)
  end

  def support_upcase(message)
    message.chars.map do |char|
      if is_upcase?(char)
        char.gsub(char, "&#{char.downcase}")
      else
        char
      end
    end.join
  end

  def support_numbers(message)
    message.gsub(/(\d+)/, '#\1 ')
  end

  def upcase_and_number_string(chars)
    with_upcase = support_upcase(chars)
    support_numbers(with_upcase)
  end

  def load_braille_letters(braille_message, braille_letters)
    braille_message[0] << braille_letters[0]
    braille_message[1] << braille_letters[1]
    braille_message[2] << braille_letters[2]
  end

  def message_translate(chars)
    braille_message = [[],[],[]]
    upcase_and_number_string(chars).each_char do |char|
      load_braille_letters(braille_message, english_letter_translate(char))
    end
    braille_message
  end

  def line_break(line)
    line_coll= []
    until line_coll[-1] == []
      line_coll << line.shift(80)
    end
    line_coll
  end

  def collect_lines(message)
    line_coll_one    = line_break(message_translate(message)[0])
    line_coll_two    = line_break(message_translate(message)[1])
    line_coll_three  = line_break(message_translate(message)[2])
    lines_collected  = [line_coll_one, line_coll_two, line_coll_three]
  end

  def print_braille(message)
    final =[]
    collect_lines(message[0]).count.times do |i|
      collect_lines(message).each do |line|
        final << line[i].join
      end
    end
    "#{final.join("\n")}"
  end

  def added_character_count(chars)
    number = upcase_and_number_string(chars).chars.find_all {|char| char.include?("#")}.count
    upcase = upcase_and_number_string(chars).chars.find_all {|char| char.include?("&")}.count
    number * 2 + upcase + 1
  end
end
