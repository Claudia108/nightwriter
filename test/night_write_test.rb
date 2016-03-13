require 'minitest/autorun'
require 'minitest/pride'
require_relative '../night_write'

class NightWriteTest < Minitest::Test
  def setup
    @night_write = NightWrite.new
  end

  def test_read_in_message_reads_in_message_file
    assert_equal String, @night_write.read_in_message.class
  end

  def test_character_count_counts_characters_printed_in_original_message_file
    assert_equal Fixnum, @night_write.character_count.class
    assert @night_write.character_count
  end
end
