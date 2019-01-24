require "rubyXL"

namespace :setup do
  desc "create excel files for tests"
  task :create do
    dir = File.join(File.dirname(__FILE__), "../excel_files")
    valid_header   = %w[name email note]
    invalid_header = %w[name  mail]
    
    alice     = ["Alice",  "alice@wonderland", "valid"]
    bob       = ["Bob"*17, "IamBob",           "invalid"]

    invalid_header_wb     = RubyXL::Workbook.new
    add_row(
      invalid_header_wb.add_worksheet("users"),
      [
        invalid_header,
        alice,
        bob
      ]
    )
    invalid_sheet_name_wb = RubyXL::Workbook.new
    add_row(
      invalid_sheet_name_wb.add_worksheet("foo"),
      [
        valid_header,
        alice,
        bob
      ]
    )
    valid_wb              = RubyXL::Workbook.new
    add_row(
      valid_wb.add_worksheet("users"),
      [
        valid_header,
        alice,
        bob
      ]
    )

    invalid_header_wb.write(File.join(dir, "invalid_header.xlsx"))
    invalid_sheet_name_wb.write(File.join(dir, "invalid_sheet_name.xlsx"))
    valid_wb.write(File.join(dir, "valid.xlsx"))
  end

  def add_row(sheet, records)
    size = sheet.sheet_data.size
    records.each_with_index do |record, row_index|
      record.each_with_index do |value, column_index|
        sheet.add_cell(size + row_index, column_index, value)
      end
    end
  end
end
