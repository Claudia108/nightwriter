require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/file_read'

class FileReadTest < Minitest::Test
  def setup
    @file_read = FileRead.new
  end

  def test_read_in_braille_reads_in_braille_file
    assert_equal Array, @file_read.read_in_braille.class
  end

  def test_character_count_counts_characters_printed_in_original_message_file
    assert_equal Fixnum, @file_read.character_count.class
    assert @file_read.character_count
  end
end
