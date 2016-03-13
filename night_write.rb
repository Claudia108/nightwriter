require_relative './lib/night_writer.rb'
require_relative 'file_read'
require 'pry'

class NightWrite
  def initialize
    @night_writer = NightWriter.new
    @file_read = FileRead.new
  end

  def read_in_message
    file = File.open(ARGV.shift || "message.txt", "r")
    file.read.chomp
  end

  def character_count
    @night_writer.print_braille(read_in_message).chars.count / 6
  end

  def write_to_braille_file
    file = File.open(ARGV.shift || "braille.txt", "w")
    file.write("#{@night_writer.print_braille(read_in_message)}")
    puts "Created 'braille.txt' containing #{character_count} characters"
  end

end

if __FILE__ == $0
  file_one = NightWrite.new
  night_writer = NightWriter.new
  message = file_one.read_in_message
  night_writer.message_translate(message)
  file_one.write_to_braille_file
end