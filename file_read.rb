
require 'pry'
require_relative 'letter'
require_relative 'night_write'

class FileRead

  def braille_chop_line(i_braille_message)
    letter_parts = i_braille_message.chars
    line = []
    until letter_parts == []
      line << letter_parts.shift(2).join
    end
    line
  end

  def combine_braille_lines(i_braille_message)
    # i = 0
    line_one   = braille_chop_line(i_braille_message[0].chomp + i_braille_message[3].chomp)
    line_two   = braille_chop_line(i_braille_message[1].chomp + i_braille_message[4].chomp)
    line_three = braille_chop_line(i_braille_message[2].chomp + i_braille_message[5].chomp)
    line_one.zip(line_two, line_three)
  end

  def braille_letter_translate(braille_letter)
    letter_map = Letter.new
    letter_map.braille_to_english[braille_letter]
  end

  def braille_message_translate(i_braille_message)
    braille_message = combine_braille_lines(i_braille_message)
    english_message = []
    @shift = false
    braille_message.each do |braille_letter|
      if braille_letter == ["..","..",".0"]
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
  message_in_braille = file_one.read_in_braille
  message_in_english = file_one.braille_message_translate(message_in_braille)
  file_one.write_to_orig_message_file(message_in_english)
end
