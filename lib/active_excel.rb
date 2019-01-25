require "active_excel/version"
require "active_excel/validated_records"
require "active_record"
require "rubyXL"

module ActiveExcel
  def build_from_excel(file_path)
    workbook = RubyXL::Parser.parse(file_path)
    table_name = self.name.underscore.pluralize
    sheet = workbook[table_name]
    column_names = sheet[0].cells.map(&:value)
    captured_attributes = self.attribute_names.map do |attribute|
      if column_names.include?(attribute)
        [attribute.to_sym, column_names.index(attribute)]
      end
    end.compact.to_h
    records = []
    sheet[1..-1].each do |row|
      if row
        attributes = captured_attributes.map do |attribute, index|
          [attribute, row[index].value]
        end.to_h
        records << self.new(attributes)
      end
    end
    ValidatedRecords.new(table_name, records)
  end
end
