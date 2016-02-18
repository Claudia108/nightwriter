require_relative 'letter'
require 'pry'

class NightWrite
  # attr_reader :message

  # def initialize(message)
  #   @message = message
  # end

  def english_letter_translate(letter)
    letter_map = Letter.new
    letter_map.english_to_braille[letter]
  end

  def message_translate(message)
    braille_message = [[],[],[]]
    message.each_char do |char|
      braille_letters = english_letter_translate(char)
      braille_message[0] << braille_letters[0]
      braille_message[1] << braille_letters[1]
      braille_message[2] << braille_letters[2]
    end
    braille_message
  end

  def print_braille(message)
    braille_message = message_translate(message)
    line_one = braille_message[0].join
    line_two = braille_message[1].join
    line_three = braille_message[2].join
    "#{line_one}\n#{line_two}\n#{line_three}"
  end

  def read_in_message
    filename = ARGV.shift || "message.txt"
    file = File.open(filename, "r")
    original_line = file.readline.chomp
    puts "Created 'braille.txt' containing #{original_line.chars.count} characters"
    original_line
    # ! letter-count counts english message (no change when caps)
  end

  def write_to_braille_file
    filename = ARGV.shift || "braille.txt"
    file = File.open(filename, "w")
    file.write("#{print_braille(read_in_message)}")
  end
end


if __FILE__ == $0
  file_one = NightWrite.new
  message = file_one.read_in_message
  file_one.message_translate(message)
  file_one.write_to_braille_file

end

  # puts ARGV.inspect
