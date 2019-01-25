require "rubyXL"
require "yaml"

namespace :setup do
  desc "create excel files for tests"
  task :delete_create do
    # Delete old files
    dir = File.join(File.dirname(__FILE__), "../excel_files")
    Dir.children(dir).each do |file_name|
      File.delete(File.join(dir, file_name))
    end

    # Read test data from a yaml file
    testcases = YAML.load_file(File.join(File.dirname(__FILE__), "testcases.yaml"))

    # Write workbooks
    testcases.each do |testcase|
      wb = RubyXL::Workbook.new
      sheet = wb[0]
      sheet.sheet_name = testcase["sheet_name"]

      testcase["records"].each_with_index do |record, row_index|
        record.each_with_index do |value, col_index|
          sheet.add_cell(row_index, col_index, value)
        end
      end

      wb.write(File.join(dir, testcase["test_name"] + ".xlsx"))
    end
  end
end
