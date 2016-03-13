require 'Minitest/autorun'
require 'Minitest/pride'
require_relative '../lib/file_reader'

class FileReaderTest < Minitest::Test
  def setup
    @letter = FileReader.new
  end
  def test_braille_letter_translate_converts_braille_letters_in_english_letters
    assert_equal "a", @letter.braille_letter_translate(["0.","..",".."])
  end

  def test_braille_number_translate_converts_braille_letters_in_numbers
      assert_equal "1", @letter.braille_number_translate(["0.","..",".."])
  end

  def test_braille_chop_line_devides_braille_lines_in_parts_of_two
    assert_equal ["0.","00",".."], @letter.braille_chop_line("0.00..")
  end

  def test_combine_braille_lines_combines_same_indexes_in_each_line_to_one_string
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
    assert_equal result, @letter.combine_braille_lines(lines)
  end

  def test_create_braille_letters_converts_braille_lines_into_letters
    braille_lines = ["0.0.0.0.",
                     "..0...0.",
                     "........"]
    letter = [["0.", "..", ".."], ["0.", "0.", ".."], ["0.", "..", ".."], ["0.", "0.", ".."]]
    assert_equal letter, @letter.create_braille_letters(braille_lines)
  end

  def test_braille_message_translate_converts_braille_letters_with_english_letters
    # for reference:
    # letters = { ["0.","..",".."] => "a", ["0.","0.",".."] => "b",
                # ["00","..",".."] => "c", ["..","..",".0"] => "&",
                # [".0",".0","00"] => "#", ["..","..",".."] => " "}
    letters_braille = ["0.","..","..", ".0",".0","00", "0.","0.","..",
                       "..","..","..", "..","..",".0", "00","..",".."]
    assert_equal "a2C", @letter.braille_message_translate(letters_braille)
  end

  def test_read_in_braille_reads_in_braille_file
    letter = ["0.0.","..0.","....","0.0.","..0.","...."]
    english_letter = "abab"
    assert_equal english_letter, @letter.braille_message_translate(letter)
  end

  def test_write_to_orig_message_file_writes_message_to_txt_file

  end
end
