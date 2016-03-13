require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/night_write'

class NightWriteTest < Minitest::Test

  def test_english_letter_translate_matches_an_english_letter_with_braille_letter
   letter = NightWrite.new
   assert_equal ["0.","..",".."], letter.english_letter_translate("a")
  end

  def test_is_upcase_returns_true_if_letter_is_capital_and_not_a_symbol_or_number
   letter = NightWrite.new
   assert letter.is_upcase?("A")
   assert letter.is_upcase?("M")
   refute letter.is_upcase?("b")
   refute letter.is_upcase?("!")
   refute letter.is_upcase?("2")
  end

  def test_is_number_returns_true_if_character_is_number
    message = NightWrite.new
    assert message.is_number?("8")
    refute message.is_number?("b")
    refute message.is_number?("!")
    refute message.is_number?("C")
  end

  def test_support_upcase_inserts_shift_character_before_letter
    letters = NightWrite.new
    assert_equal "a&b&c a &fa", letters.support_upcase("aBC a Fa")
  end

  def test_support_numbers_adds_pound_char_before_first_letter_and_space_behind_last
    letters = NightWrite.new
    assert_equal "a#253 alm #1  a", letters.support_numbers("a253alm 1 a")
  end

  def test_upcase_and_number_string_inserts_all_special_characters_in_string
    letters = NightWrite.new
    assert_equal "a#53 m&a#1 a #7 ", letters.upcase_and_number_string("a53mA1a 7")
  end

  def test_load_braille_letters_collects_each_part_of_braille_letter_in_seperate_array
    message = NightWrite.new
    braille_letter = [".0", ".0", "00"]
    braille_message = [[".."],[".0"],["00"]]
    assert_equal [".0"], message.load_braille_letters(braille_message, braille_letter)
    # assert_equal [".0"], message.load_braille_letters(braille_message[1], braille_letter[1])
    # assert_equal ["00"], message.load_braille_letters(braille_message[2], braille_letter[2])
  end

  def test_message_translate_converts_normal_letters_into_braille_letters
    input = NightWrite.new
    letters = "77 aH!"
    braille_letters = [[".0", "00", "00", "..", "..", "0.", "..", "0.", ".."],
                       [".0", "00", "00", "..", "..", "..", "..", "00", "00"],
                       ["00", "..", "..", "..", "..", "..", ".0", "..", "0."]]
    assert_equal braille_letters, input.message_translate(letters)
  end

  def test_line_break_breaks_the_line_after_80_characters
    message = NightWrite.new
    line =        ["1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0"]

    line_pieces = [["1","2","3","4","5","6","7","8","9","0",
                    "1","2","3","4","5","6","7","8","9","0",
                    "1","2","3","4","5","6","7","8","9","0",
                    "1","2","3","4","5","6","7","8","9","0"],
                   ["1","2","3","4","5","6","7","8","9","0",
                    "1","2","3","4","5","6","7","8","9","0"],[]]
    assert_equal line_pieces, message.line_break(line)
    assert_equal 40, message.line_break(line_pieces)[0][0].length
  end

  def test_print_braille_prints_braille_letters_next_to_each_other
    message = NightWrite.new
     # for reference:
     # letter_a = {"a" => ["0.","..",".."]}
     # letter_b = {"b" => ["0.","0.",".."]}
    input = "abaa"
    output = [["0.", "0.", "0.", "0."],
              ["..", "0.", "..", ".."],
              ["..", "..", "..", ".."]]
    assert_equal output, message.message_translate(input)
  end
end
