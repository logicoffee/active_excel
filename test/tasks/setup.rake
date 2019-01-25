require "rubyXL"
require "yaml"

namespace :setup do
  desc "create excel files for tests"
  task :create do
    dir = File.join(File.dirname(__FILE__), "../excel_files")
    testcases = YAML.load_file(File.join(File.dirname(__FILE__), "testcases.yaml"))

    testcases.each do |testcase|
      wb = RubyXL::Workbook.new
      sheet = wb.add_worksheet(testcase["sheet_name"])
      testcase["records"].each_with_index do |record, row_index|
        record.each_with_index do |value, col_index|
          sheet.add_cell(row_index, col_index, value)
        end
      end
      wb.write(File.join(dir, testcase["test_name"] + ".xlsx"))
    end
  end
end
