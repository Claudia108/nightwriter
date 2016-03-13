require_relative 'letter'
require 'pry'

class FileRead

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

  # def number_intake(braille_letter)
  #   if braille_letter == [".0",".0","00"]
  #     @num_shift = true
  #   elsif @num_shift == true
  #     braille_number_translate(braille_letter)
  #   end
  # end

  def braille_message_translate(i_braille_message)
    braille_lines = combine_braille_lines(i_braille_message)
    braille_letters = create_braille_letters(braille_lines)
    english_message = []
    @shift = false
    braille_letters.each do |braille_letter|
      if braille_letter == [".0",".0","00"]
        @num_shift = true
      elsif @num_shift == true && braille_letter == ["..","..",".."]
        @num_shift = false
      elsif @num_shift == true
        english_letter = braille_number_translate(braille_letter)
        english_message << english_letter
      elsif braille_letter == ["..","..",".0"]
        @shift = true
      elsif @shift == true
        english_letter = braille_letter_translate(braille_letter)
        english_message << english_letter.upcase
        @shift = false
      else
        english_letter = braille_letter_translate(braille_letter)
        english_message << english_letter
      end
    end
    "#{english_message.join}"
  end

  def read_in_braille
    filename = ARGV.shift || "braille.txt"
    file = File.open(filename, "r")
    file.readlines
  end

  def write_to_orig_message_file(message_in_english)
    filename = ARGV.shift || "original_message.txt"
    file = File.open(filename, "w")
    file.write("#{braille_message_translate(read_in_braille)}")
    puts "Created 'original_message.txt' with #{braille_message_translate(read_in_braille).chars.count} characters"
  end
end

if __FILE__ == $0
  file_one = FileRead.new
  message_in_braille = file_one.read_in_braille # array of lines
  message_in_english = file_one.braille_message_translate(message_in_braille)
  file_one.write_to_orig_message_file(message_in_english)
end