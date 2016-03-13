require_relative './lib/file_reader'
require 'pry'

class FileRead

  def initialize
    @file_reader = FileReader.new
  end

  def read_in_braille
    file = File.open(ARGV.shift || "braille.txt", "r")
    file.readlines
  end

  def character_count
    @file_reader.braille_message_translate(read_in_braille).chars.count
  end

  def write_to_orig_message_file(message_in_english)
    file = File.open(ARGV.shift || "original_message.txt", "w")
    file.write("#{@file_reader.braille_message_translate(read_in_braille)}")
    puts "Created 'original_message.txt' with #{character_count} characters"
  end
end

if __FILE__ == $0
  file_one = FileRead.new
  file_reader = FileReader.new
  message_in_braille = file_one.read_in_braille # array of lines
  message_in_english = file_reader.braille_message_translate(message_in_braille)
  file_one.write_to_orig_message_file(message_in_english)
end
