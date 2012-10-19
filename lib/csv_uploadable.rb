require "csv_uploadable/version"

module CsvUploadable
  extend ActiveSupport::Concern

  included do
    def csv_upload
      raise 'Define COLUMN_NAMES constant in inherit controller' unless self.class.const_defined?(:COLUMN_NAMES)

      filepath = self.class::CsvUploadable::FORM_TEMPLATE || 'admin/shared/csv_upload_form'
      render :file => filepath, :controller_name => self.class.controller_name
    end

    def import_csv
      csv_body = params[:file].read
      csv_rows = CSV.parse(csv_body.gsub(/\r\n/, "\n").gsub("", "\n"))
      csv_rows.shift

      csv_rows.each do |row|
        attributes = {}

        # update
        if row.first.present?
          model_obj = nil
          row.each_with_index do |value, index|
            if index.zero?
              model_obj = model_class.find(value)
            else
              attributes[self.class::CsvUploadable::COLUMN_NAMES[index]] = convert_character_code_and_data_format(value)
            end
          end
          model_obj.update_attributes!(attributes)

        # insert
        else
          row.each_with_index do |value, index|
            next if index.zero?
            attributes[self.class::CsvUploadable::COLUMN_NAMES[index]] = convert_character_code_and_data_format(value)
          end
          model_class.create!(attributes)
        end
      end

      redirect_to url_for(:action => 'index'), :notice => 'finish'
    end

    private

    def model_class
      controller_name.classify.constantize
    end

    def convert_character_code_and_data_format(string)
      return if string.blank?

      string = NKF::nkf('-w', string)
      convert_data_format
    end

    def convert_data_format
      self.class.CsvUploadable::convert_data_format
    end
  end
end
