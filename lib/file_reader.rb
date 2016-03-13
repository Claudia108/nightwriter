require_relative 'letter'
require 'pry'

class FileReader

  def initialize
    @letter_map = Letter.new
  end

  def braille_letter_translate(braille_letter)
    @letter_map.braille_to_english[braille_letter]
  end

  def braille_number_translate(braille_letter)
    @letter_map.braille_numbers[braille_letter]
  end

  def braille_chop_line(i_braille_message)
    letter_parts = i_braille_message.chars
    line = []
    until letter_parts == []
      line << letter_parts.shift(2).join
    end
    line
  end

  def combine_braille_lines(lines)
    combined_lines = ["", "", ""]
    lines.each_with_index do |line, i|
      if i % 3 == 0
        combined_lines[0] << line.chomp
      elsif i % 3 == 1
        combined_lines[1] << line.chomp
      else
        combined_lines[2] << line.chomp
      end
    end
    combined_lines
  end

  def create_braille_letters(braille_lines)
    line_one   = braille_lines[0].chars
    line_two   = braille_lines[1].chars
    line_three = braille_lines[2].chars
    letters = []
    (line_one.length / 2).times do
      character = []
      character << line_one.shift(2).join
      character << line_two.shift(2).join
      character << line_three.shift(2).join
      letters << character
    end
    letters
  end

  def braille_message_translate(i_braille_message)
    braille_lines = combine_braille_lines(i_braille_message)
    english_message = []
    create_braille_letters(braille_lines).each do |braille_letter|
      if braille_letter == [".0",".0","00"]
        @num_shift = true
      elsif @num_shift == true && braille_letter == ["..","..",".."]
        @num_shift = false
      elsif @num_shift == true
        english_message << braille_number_translate(braille_letter)
      elsif braille_letter == ["..","..",".0"]
        @shift = true
      elsif @shift == true
        english_message << braille_letter_translate(braille_letter).upcase
        @shift = false
      else
        english_message << braille_letter_translate(braille_letter)
      end
    end
    "#{english_message.join}"
  end
end
