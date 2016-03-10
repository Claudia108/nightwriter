require 'minitest/autorun'
require 'minitest/pride'
require_relative 'night_write'

class NightWriteTest < Minitest::Test

 def test_it_translates_english_letter_into_braille_letters
   letter = NightWrite.new
   assert_equal ["0.","..",".."], letter.english_letter_translate("a")
 end

 def test_it_returns_true_if_letter_is_capital_and_not_a_symbol
   letter = NightWrite.new
   assert letter.is_upcase?("A")
   refute letter.is_upcase?("!")
 end

 def test_it_inserts_a_shift_character_for_capital_letter
   letter = NightWrite.new
   assert_equal [["..", "0."], ["..", ".."], [".0", ".."]], letter.message_translate("A")
 end

 def test_it_prints_braille_letters_next_to_each_other
   message = NightWrite.new
   assert_equal [["0.", "0.", "0.", "0."], ["..", "0.", "..", ".."], ["..", "..", "..", ".."]], message.message_translate("abaa")
 end

 def test_it_returns_a_string_printed_on_three_lines
   skip
   message = NightWrite.new
   assert_equal "0.0.0.\n..0...\n......", message.print_braille("aba")
 end

 def test_it_breaks_the_line_after_40_characters
   skip
   line = NightWrite.new
   assert_equal "#{line}\n", line.line_break(40)
 end

 def test_it_prints_an_additional_character_before_each_capital_letter
   skip
   message = NightWrite.new
   assert_equal "..0.\n....\n.0..", message.print_braille("A")
 end

 def test_is_number_checks_for_number_character
   message = NightWrite.new
   number = "8"
   assert_equal true, message.is_number?(number)
 end

 def test_support_numbers_supports_the_translation_of_number_with_surrounding_characters
   skip
   message = NightWrite.new
   number = "5"
   braille_number = ["++","++","++"], ["55","55","55"], ["  ", "  ","  "]
   lines = [
     "0000",
     "1111",
     "2222",
     "3333",
     "4444",
     "5555"
   ]
   result = [
     "00003333",
     "11114444",
     "22225555"
   ]

   assert_equal
   # input english numbers
   # map those with braille letters
   # add special character (#) in front and space in back
   # output: number+ 2 characters

   # if statement: if a number shows up add #
   # keep track of length of numbers
   # after last add space

 end

end
