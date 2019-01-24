require "rubyXL"
require "test_helper"
require "model/user"

class ActiveExcelTest < Minitest::Test
  def setup
    @base_path = File.join(File.dirname(__FILE__), "excel_files")
  end

  def test_that_it_has_a_version_number
    refute_nil ::ActiveExcel::VERSION
  end

  def test_invalid_header
    file_path = File.join(@base_path, "invalid_header.xlsx")
    wb = RubyXL::Parser.parse(file_path)
    refute_nil wb["users"]
    validated_records = User.build_from_excel(file_path)
    assert_equal 2, validated_records.invalid_records.size
  end

  def test_invalid_sheet_name
    file_path = File.join(@base_path, "invalid_sheet_name.xlsx")
    wb = RubyXL::Parser.parse(file_path)
    assert_nil wb["users"]

    # Raise exception to invalid sheet name
    assert_raises do
      User.build_from_excel(file_path)
    end
  end

  def test_valid_workbook_with_invalid_records
    file_path = File.join(@base_path, "valid.xlsx")
    wb = RubyXL::Parser.parse(file_path)
    refute_nil wb["users"]

    validated_records = User.build_from_excel(file_path)
    assert_equal 2, validated_records.all_records.size
    assert_equal 1, validated_records.valid_records.size
    assert_equal 1, validated_records.invalid_records.size
  end
end
