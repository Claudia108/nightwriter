require_relative 'letter'
require 'pry'
require 'pry-nav'

class NightWrite

  def initialize
    @letter_map = Letter.new
    @count = 0
  end

  # def english_letter_translate(letter, num=false)
  #   translation = []
  #   if num == true
  #     letter.first.each_char do |char|
  #       translation << @letter_map.english_to_braille[char]
  #     end
  #     translation
  #   else
  #     @letter_map.english_to_braille[letter]
  #   end
  # end

  def english_letter_translate(char)
      @letter_map.english_to_braille[char.downcase]
  end

  def is_upcase?(letter)
    symbols = [" ", "!", "'", "-", ".", ",", "?", "#", "&",
              "1", "2", "3", "4", "5", "6", "7", "8", "9","0"]
    letter == letter.upcase && !symbols.include?(letter)
  end

  # def support_upcase(braille_letter)
  #   braille_letter = english_letter_translate("Cap")
  #   load_braille_letters(braille_message, braille_letter)
  #   binding.pry
  # end

  def is_number?(number)
    ("0".."9").to_a.include?(number)
  end

  # def map_numbers_with_index(characters)
  #   characters.chars.map.with_index do |char, index|
  #    index if is_number?(char)
  #   end.compact
  #   # indexes.compact
  # end

  def support_numbers(message)
    @count += 2
    message.gsub(/(\d+)/, '#\1 ')
  end

  def support_upcase(message)
    message.chars.map do |char|
      if is_upcase?(char)
        @count += 1
        char.gsub(char, "&#{char.downcase}")
      else
        char
      end
    end.join
  end

  def upcase_and_number_string(chars)
    with_upcase = support_upcase(chars)
    support_numbers(with_upcase)
  end

  def load_braille_letters(braille_message, braille_letters)
    # binding.pry
    braille_message[0] << braille_letters[0]
    braille_message[1] << braille_letters[1]
    braille_message[2] << braille_letters[2]
  end

  def message_translate(chars)
    braille_message = [[],[],[]]
    upcase_and_number_string(chars).each_char do |char|
      braille_letters = english_letter_translate(char)
      # binding.pry
      load_braille_letters(braille_message, braille_letters)
    end
    # binding.pry
    braille_message
  end


  # def message_translate(message)
  #   braille_message = [[],[],[]]
  #   @count = 0
  #   message.each_char do |char|
  #     if is_upcase?(char)
  #       braille_letters = english_letter_translate("Cap")
  #       load_braille_letters(braille_message, braille_letters)
  #       @count += 1
  #     elsif is_number?(char)
  #       num = support_numbers(char)
  #       # binding.pry
  #       braille_letters = english_letter_translate(num, true)
  #       load_braille_letters(braille_message, braille_letters)
  #       @count += 2
  #     end
  #     braille_letters = english_letter_translate(char.downcase)
  #     load_braille_letters(braille_message, braille_letters)
  #   end
  #   braille_message
  # end

  def line_break(braille_message)
    line = braille_message
    line_coll= []
    until line_coll[-1] == []
      line_coll << line.shift(80)
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
