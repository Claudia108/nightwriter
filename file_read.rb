# require_relative 'letter'
require 'pry'
require_relative 'letter'
require_relative 'night_write'

class FileRead


  # def braille_translate_line_two(message)
  #   letter_parts = message[1].chars
  #   line_two = []
  #   until letter_parts == []
  #     line_two << letter_parts.shift(2).join
  #   end
  #   line_two
  # end
  #
  # def braille_translate_line_three(message)
  #   letter_parts = message[2].chars
  #   line_three = []
  #   until letter_parts == []
  #     line_three << letter_parts.shift(2).join
  #   end
  #   line_three
  # end
  #
  # def braille_translate_lines(index)
  #   letter_parts = message[index].chars
  #   line = []
  #   until letter_parts == []
  #     line << letter_parts.shift(2).join
  #   end
  #   line
  # end

  # line_one = something.braille_translate_lines(0)
  # line_two = something.braille_translate_lines(1)
  # line_three = something.braille_translate_lines(2)


  def braille_translate_line(message)
    letter_parts = message.chars
    line = []
    until letter_parts == []
      line << letter_parts.shift(2).join
    end
    line
  end


  def combine_braille_lines(braille_message)
    line_one = braille_translate_line(braille_message[0].chomp)
    line_two = braille_translate_line(braille_message[1].chomp)
    line_three = braille_translate_line(braille_message[2].chomp)

    line_one.line_two, line_three)
  end

  def braille_letter_translate(letter)
    letter_map = Letter.new
    letter_map.braille_to_english[letter]
  end

  def braille_message_translate(i_braille_message)
    braille_message = combine_braille_lines(i_braille_message)
    english_message = []

    braille_message.each do |braille_letter|
      english_letter = braille_letter_translate(braille_letter)
      english_message << english_letter
    end
    final_message = english_message.join
    "#{final_message}"
  end

    # braille.each do |letter|
    #   if data.value == letter
    #     data.key
    #   english_message << data.key
    #   end
    # end

    # combine same index strings of each line in an array
    # match it to letters (if braille array == data.values print data.key)
    # special case for upper case!


  def read_in_braille
    filename = ARGV.shift || "braille.txt"
    file = File.open(filename, "r")
    original_line = file.readlines
    puts "Created 'original_message.txt' with #{original_line.count} characters"
    original_line
    # character count does not work with the arrays,
    # maybe count in write_to_orig_message_file?
  end

  def write_to_orig_message_file(message_in_english)
    filename = ARGV.shift || "original_message.txt"
    file = File.open(filename, "w")
    # message = braille_message_translate(read_in_braille)
    file.write("#{message_in_english}")
  end
end

if __FILE__ == $0
  file_one = FileRead.new
  message_in_braille = file_one.read_in_braille
  message_in_english = file_one.braille_message_translate(message_in_braille)
  file_one.write_to_orig_message_file(message_in_english)

end
