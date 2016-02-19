require_relative 'letter'
require 'pry'
require 'pry-nav'

class NightWrite

  def english_letter_translate(letter)
    letter_map = Letter.new
    letter_map.english_to_braille[letter]
  end

  def is_upcase?(letter)
    symbols = [" ", "!", "'", "-", ".", ",", "?"]
    letter == letter.upcase && !symbols.include?(letter)
  end

  def load_braille_letters(braille_message, braille_letters)
    braille_message[0] << braille_letters[0]
    braille_message[1] << braille_letters[1]
    braille_message[2] << braille_letters[2]
  end

  def message_translate(message)
    braille_message = [[],[],[]]
    @count = 0
    message.each_char do |char|
      if is_upcase?(char)
        braille_letters = english_letter_translate("Cap")
        load_braille_letters(braille_message, braille_letters)
        @count += 1
      end
      braille_letters = english_letter_translate(char.downcase)
      load_braille_letters(braille_message, braille_letters)
    end
    braille_message
  end

  def line_break(braille_message)
    line = braille_message
    line_coll= []
    until line_coll[-1] == []
      line_coll << line.shift(40)
    end
    line_coll
  end

  def print_braille(message)
    braille_message = message_translate(message)
    final =[]
    line_coll_one    = line_break(braille_message[0])
    line_coll_two    = line_break(braille_message[1])
    line_coll_three  = line_break(braille_message[2])
    lines_collected  = [line_coll_one, line_coll_two, line_coll_three]
    line_coll_one.count.times do |i|
      lines_collected.each do |line|
        final << line[i].join
      end
    end
    "#{final.join("\n")}"
  end

  def read_in_message
    filename = ARGV.shift || "message.txt"
    file = File.open(filename, "r")
    file.read.chomp
  end

  def write_to_braille_file
    filename = ARGV.shift || "braille.txt"
    file = File.open(filename, "w")
    file.write("#{print_braille(read_in_message)}")
    puts "Created 'braille.txt' containing #{(print_braille(read_in_message).chars.count / 6) - @count} characters"
  end
end

if __FILE__ == $0
  file_one = NightWrite.new
  message = file_one.read_in_message
  file_one.message_translate(message)
  file_one.write_to_braille_file
end
