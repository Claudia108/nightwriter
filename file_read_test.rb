require 'Minitest/autorun'
require 'Minitest/pride'
require_relative 'file_read'

class FileReadTest < Minitest::Test
  def test_it_converts_braille_message_in_english_letters
    message = FileRead.new
    assert_equal "a", message.braille_letter_translate(["0.","..",".."])
  end

  def test_it_devides_braille_lines_in_parts_of_two
    line = FileRead.new
    assert_equal ["0.","00",".."], line.braille_chop_line("0.00..")
  end

  def test_it_combines_same_indexes_in_each_line_to_one_string
    letter = FileRead.new
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
    assert_equal result, letter.combine_braille_lines(lines)
  end

  def test_it_reads_braille_letters_from_braille_lines
    reader = FileRead.new
    braille_lines = [
      "00003333",
      "11114444",
      "22225555"
    ]

    output_letter = ["00", "11", "22"]
    assert_equal output_letter, reader.create_braille_letters(braille_lines).first
  end

  def test_it_matches_a_braille_letter_with_an_english_letter
    letter_match = FileRead.new
    letters = { ["0.","..",".."] => "a", ["0.","0.",".."] => "b", ["00","..",".."] => "c"}
    letters_braille = [["0.","..",".."],["0.","0.",".."],["00","..",".."]]
    assert_equal "b", letter_match.braille_letter_translate(letters_braille[1])
  end

  def test_it_reads_a_whole_file
    letter = ["0.0.","..0.","....","0.0.","..0.","...."]
    file_read = FileRead.new
    english_letter = "abab"
    assert_equal english_letter, file_read.braille_message_translate(letter)
  end
end
