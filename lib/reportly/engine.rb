module Reportly
  module Engine
    # Original code https://gist.github.com/bgreenlee/72234   
    def self.report(items, *fields)
      # find max length for each field; start with the field names themselves
      fields = items.first.class.column_names unless fields.any?
      max_len = Hash[*fields.map {|f| [f, f.to_s.length]}.flatten]
      items.each do |item|
        fields.each do |field|
          len = item.read_attribute(field).to_s.length
          max_len[field] = len if len > max_len[field]
        end
      end

      report = []
      
      border = '+-' + fields.map {|f| '-' * max_len[f] }.join('-+-') + '-+'
      title_row = '| ' + fields.map {|f| sprintf("%-#{max_len[f]}s", f.to_s) }.join(' | ') + ' |'

      report << border
      report <<  title_row
      report << border

      items.each do |item|
        row = '| ' + fields.map {|f| sprintf("%-#{max_len[f]}s", item.read_attribute(f)) }.join(' | ') + ' |'
        report <<  row
      end

      report << border
      report <<  "#{items.length} rows in set"
      report
    end
  end
end
