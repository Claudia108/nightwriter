require 'minitest/autorun'
require 'minitest/pride'
require_relative 'night_write'

class NightWriteTest < Minitest::Test

 def test_it_translates_english_letter_into_braille_letters
   letter = NightWrite.new
   assert_equal ["0.","..",".."], letter.english_letter_translate("a")
 end

 def test_it_prints_braille_letters_next_to_each_other
   message = NightWrite.new
   assert_equal [["0.", "0.", "0."], ["..", "0.", ".."], ["..", "..", ".."]], message.message_translate("aba")
 end

 def test_it_returns_a_string_printed_on_three_lines
   message = NightWrite.new
   assert_equal "0.0.0.\n..0...\n......", message.print_braille("aba")
 end

 def test_it_prints_an_additional_character_before_each_capital_letter
   message = NightWrite.new
   assert_equal "..0.\n....\n.0..", message.print_braille("A")
 end

end
