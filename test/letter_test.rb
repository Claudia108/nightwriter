require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/letter.rb'

class LetterTest < Minitest::Test
  def setup
    @letter = Letter.new
  end

  def test_english_to_braille_matches_english_letter_with_braille_letter
    english_letter_one = "a"
    english_letter_two = "!"
    braille_letter_one = ["0.","..",".."]
    braille_letter_two = ["..","00","0."]
    assert_equal braille_letter_one, @letter.english_to_braille[english_letter_one]
    assert_equal braille_letter_two, @letter.english_to_braille[english_letter_two]
    assert_equal 45, @letter.english_to_braille.length
  end

  def test_braille_to_english_matches_braille_letter_with_english_letter
    english_letter_one = "a"
    english_letter_two = "p"
    braille_letter_one = ["0.","..",".."]
    braille_letter_two = ["00","0.","0."]
    assert_equal english_letter_one, @letter.braille_to_english[braille_letter_one]
    assert_equal english_letter_two, @letter.braille_to_english[braille_letter_two]
    assert_equal 34, @letter.braille_to_english.length
  end

  def test_braille_numbers_matches_braille_letter_with_number
    english_number_one = "1"
    english_number_two = "7"
    braille_number_one = ["0.","..",".."]
    braille_number_two = ["00","00",".."]
    assert_equal english_number_one, @letter.braille_numbers[braille_number_one]
    assert_equal english_number_two, @letter.braille_numbers[braille_number_two]
    assert_equal 12, @letter.braille_numbers.length
  end
end
