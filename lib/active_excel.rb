require "active_excel/version"
require "active_excel/validated_records"
require "active_record"
require "rubyXL"

module ActiveExcel
  def build_from_excel(file_path)
    workbook = RubyXL::Parser.parse(file_path)
    table_name = self.name.downcase.pluralize # 例えばActiveRecordならactiverecordsになってしまう
    sheet = workbook[table_name]
    column_names = sheet[0].cells.map(&:value)
    records = []
    sheet[1..-1].each do |row|
      attributes = column_names
                     .map
                     .with_index do |column_name, index|
                       [column_name.to_sym, row[index].value]
                     end
                     .to_h
      records << self.new(attributes)
    end
    ValidatedRecords.new(table_name, records)
  end
end
