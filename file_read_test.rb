require 'Minitest/autorun'
require 'Minitest/pride'
require_relative 'file_read'

class FileReadTest < Minitest::Test
  def test_it_converts_braille_message_in_english_letters
    skip
    message = FileRead.new
    assert_equal "a", message.braille_translate(["","",""])
  end

  def test_it_devides_braille_line_one_in_parts_of_two
    line = FileRead.new
    assert_equal ["00","..","0."], line.braille_translate_line_one(["00..0."])
  end

  def test_it_devides_braille_line_two_in_parts_of_two
    line = FileRead.new
    assert_equal ["..","0.","00"], line.braille_translate_line_two(["00..0.", "..0.00"])
  end

  def test_it_devides_braille_line_three_in_parts_of_two
    line = FileRead.new
    assert_equal ["0.","00",".."], line.braille_translate_line_three(["00..0.", "..0.00", "0.00.."])
  end

  def test_it_adds_same_index_strings_in_each_line_to_one_string
    letter = FileRead.new
    line_one = ["00","0.",".."]
    line_two = ["11","1.",".1"]
    line_three = ["22","2.",".2"]
    assert_equal [["00","11","22"],["0.","1.","2."],["..",".1",".2"]], letter.combine_braille_lines(["00","0.",".."], ["11","1.",".1"],["22","2.",".2"])
  end

  def test_it_lists_all_letters_in_the_message_in_a_nested_array
    skip
  end

  def test_it_matches_braille_letters_with_english_letters
    letter_match = FileRead.new
    letters = { ["0.","..",".."] => "a", ["0.","0.",".."] => "b", ["00","..",".."] => "c"}
    letters_braille = [["0.","..",".."],["0.","0.",".."],["00","..",".."]]
    assert_equal "b", letter_match.braille_letter_translate(letters_braille[1])
    assert_equal "abc", letter_match.braille_message_translate(letters_braille)
  end

  def test_
    
  end
end
