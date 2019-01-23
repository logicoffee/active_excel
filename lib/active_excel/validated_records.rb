require "active_record"

module ActiveExcel
  class ValidatedRecords
    def initialize(table_name, records)
      @table_name = table_name
      @records    = records
    end

    def all_records
      @records
    end

    def valid_records
      @records.select(&:valid?)
    end

    def invalid_records
      @records.reject(&:valid?)
    end
  end
end
