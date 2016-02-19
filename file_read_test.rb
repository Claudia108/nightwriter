require 'Minitest/autorun'
require 'Minitest/pride'
require_relative 'file_read'

class FileReadTest < Minitest::Test
  def test_it_converts_braille_message_in_english_letters
    skip
    message = FileRead.new
    assert_equal "a", message.braille_translate(["","",""])
  end

  def test_it_devides_braille_lines_in_parts_of_two
    line = FileRead.new
    assert_equal ["0.","00",".."], line.braille_chop_line("0.00..")
  end

  def test_it_combines_same_indexes_in_each_line_to_one_string
    skip
    letter = FileRead.new
    line_one = "00","0.",".."
    line_two = "11","1.",".1"
    line_three = "22","2.",".2"
    assert_equal ["00","11","22"],["0.","1.","2."],["..",".1",".2"], letter.combine_braille_lines([line_one, line_two,line_three])
  end

  def test_it_matches_a_braille_letter_with_an_english_letter
    letter_match = FileRead.new
    letters = { ["0.","..",".."] => "a", ["0.","0.",".."] => "b", ["00","..",".."] => "c"}
    letters_braille = [["0.","..",".."],["0.","0.",".."],["00","..",".."]]
    assert_equal "b", letter_match.braille_letter_translate(letters_braille[1])
  end

  def test_it_translates_braille_message_to_english_message
    skip
    letter_match = FileRead.new
    letters_braille = [["0.","..",".."],["0.","0.",".."],["00","..",".."]]
    assert_equal "abc", letter_match.braille_message_translate(letters_braille)
  end
end
