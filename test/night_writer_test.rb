require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/night_writer'

class NightWriterTest < Minitest::Test
  def setup
    @letter = NightWriter.new
  end

  def test_english_letter_translate_matches_an_english_letter_with_braille_letter
   assert_equal ["0.","..",".."], @letter.english_letter_translate("a")
  end

  def test_is_upcase_returns_true_if_letter_is_capital_and_not_a_symbol_or_number
   assert @letter.is_upcase?("A")
   assert @letter.is_upcase?("M")
   refute @letter.is_upcase?("b")
   refute @letter.is_upcase?("!")
   refute @letter.is_upcase?("2")
  end

  def test_is_number_returns_true_if_character_is_number
    assert @letter.is_number?("8")
    refute @letter.is_number?("b")
    refute @letter.is_number?("!")
    refute @letter.is_number?("C")
  end

  def test_support_upcase_inserts_shift_character_before_letter
    assert_equal "a&b&c a &fa", @letter.support_upcase("aBC a Fa")
  end

  def test_support_numbers_adds_pound_char_before_first_letter_and_space_behind_last
    assert_equal "a#253 alm #1  a", @letter.support_numbers("a253alm 1 a")
  end

  def test_upcase_and_number_string_inserts_all_special_characters_in_string
    assert_equal "a#53 m&a#1 a #7 ", @letter.upcase_and_number_string("a53mA1a 7")
  end

  def test_load_braille_letters_collects_each_part_of_braille_letter_in_seperate_array
    braille_letter = [".0", ".0", "00"]
    braille_message = [[".."],[".0"],["00"]]
    assert_equal ["00", "00"], @letter.load_braille_letters(braille_message, braille_letter)
  end

  def test_message_translate_converts_normal_letters_into_braille_letters
    letters = "77 aH!"
    braille_letters = [[".0", "00", "00", "..", "..", "0.", "..", "0.", ".."],
                       [".0", "00", "00", "..", "..", "..", "..", "00", "00"],
                       ["00", "..", "..", "..", "..", "..", ".0", "..", "0."]]
    assert_equal braille_letters, @letter.message_translate(letters)
  end

  def test_line_break_breaks_the_line_after_80_characters
    line =        ["1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0",
                   "1","2","3","4","5","6","7","8","9","0"]

    line_pieces = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                   ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"], []]
    assert_equal line_pieces, @letter.line_break(line)
    assert_equal 80, @letter.line_break(line_pieces)[0][0].length
  end

  def test_print_braille_prints_braille_letters_next_to_each_other
     # for reference:
     # letter_a = {"a" => ["0.","..",".."]}
     # letter_b = {"b" => ["0.","0.",".."]}
    input = "abaa"
    output = [["0.", "0.", "0.", "0."],
              ["..", "0.", "..", ".."],
              ["..", "..", "..", ".."]]
    assert_equal output, @letter.message_translate(input)
  end
end
