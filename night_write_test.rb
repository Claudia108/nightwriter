require 'minitest/autorun'
require 'minitest/pride'
require_relative 'night_write'

class NightWriteTest < Minitest::Test

  def test_english_letter_translate_matches_an_english_letter_with_braille_letter
   letter = NightWrite.new
   letter_a = {"a" => ["0.","..",".."]}
   assert_equal ["0.","..",".."], letter.english_letter_translate("a")
  end

  def test_is_upcase_returns_true_if_letter_is_capital_and_not_a_symbol_or_number
   letter = NightWrite.new
   assert letter.is_upcase?("A")
   refute letter.is_upcase?("!")
   refute letter.is_upcase?("2")
  end

  def test_support_upcase_inserts_shift_character_in_front_of_letter
   letter = NightWrite.new
   shift_character = {"Cap" => ["..","..",".0"]}
   character = {"a" => ["0.","..",".."]}
   assert_equal [["..", "0."], ["..", ".."], [".0", ".."]], letter.message_translate("A")
  end

  def test_is_number_returns_true_if_character_is_number
    message = NightWrite.new
    number = "8"
    assert_equal true, message.is_number?(number)
  end

  def test_support_numbers_inserts_shift_character_in_front_of_number
    skip
    letter = NightWrite.new
    # For Reference:
    # shift_character = {"#" => [".0",".0","00"]}
    # character = {"1" => ["0.","..",".."]}
    assert_equal [[".0", "0."], [".0", ".."], ["00", ".."]], letter.message_translate("77")
  end

  def test_map_numbers_with_index_indexes_numbers
    skip
    letters = NightWrite.new
    letter_characters = {
      "a" => ["0.","..",".."],
      "b" => ["0.","0.",".."]
    }

    number_characters = {
      "1" => ["0.","..",".."],
      "2" => ["0.","0.",".."],
      "3" => ["00","..",".."]
    }
    assert_equal [2, 4, 5], letters.map_numbers_with_index("ab2a31")
  end

  def test_support_numbers_adds_pound_char_before_first_letter_and_space_behind_last
    letters = NightWrite.new
    assert_equal ["a#23 a#1 a"], letters.support_numbers("a23a1a")
  end

  def test_upcase_and_number_string_inserts_all_special_characters_in_string
    letters = NightWrite.new
    assert_equal ["a#23 Capa#1 a"], letters.support_numbers("a23A1a")
  end

  def test_load_braille_letters_collects_each_part_of_braille_letter_in_seperate_array

  end

  def test_message_translate_converts_normal_letters_into_braille_letters

  end

  def test_line_break_breaks_the_line_after_80_characters
    skip
    line = NightWrite.new
    assert_equal "#{line}\n", line.line_break(80)
  end

  def test_print_braille_prints_braille_letters_next_to_each_other
   message = NightWrite.new
   letter_a = {"a" => ["0.","..",".."]}
   letter_b = {"b" => ["0.","0.",".."]}
   assert_equal [["0.", "0.", "0.", "0."],
                 ["..", "0.", "..", ".."],
                 ["..", "..", "..", ".."]], message.message_translate("abaa")
  end


  def test_support_numbers_writes_number
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


   # input english numbers
   # map those with braille letters
   # add special character (#) in front and space in back
   # output: number+ 2 characters

   # if statement: if a number shows up add #
   # keep track of length of numbers
   # after last add space

  end

  def test_it_can_translate_a_string_of_numbers
   skip
   message = NightWrite.new
   english_letters = "77"
   braille_letters = [[".0",".0","00"],["0.","..",".."], ["0.","0.",".."],["..","..",".."]]
   assert_equal braille_letters, message.message_translate(english_letters)
  end

end
