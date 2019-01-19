require "rubyXL"
require "test_helper"
require "model/user"

class ActiveExcelTest < Minitest::Test
  def setup
    @file_path = File.join(File.dirname(__FILE__), "excel_files")
  end

  def test_that_it_has_a_version_number
    refute_nil ::ActiveExcel::VERSION
  end

  def test_invalid_header
    wb = RubyXL::Parser.parse(File.join(@file_path, "invalid_header.xlsx"))
    refute_nil wb["users"]
  end

  def test_invalid_sheet_name
    wb = RubyXL::Parser.parse(File.join(@file_path, "invalid_sheet_name.xlsx"))
    assert_nil wb["users"]
  end

  def test_valid_book_with_invalid_records
    wb = RubyXL::Parser.parse(File.join(@file_path, "valid.xlsx"))
    refute_nil wb["users"]
  end
end
