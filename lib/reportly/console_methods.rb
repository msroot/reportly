require "reportly/engine"

module Reportly
  module ConsoleMethods
    
    class ReportlyNotValid < StandardError; end
    
    def self.report(model, *fields)
      raise ReportlyNotValid, "Reportly accepts only ActiveRecord Objects" unless is_valid_klass?(model)
    
      # call :all for ActiveRecord::Base model
        model = model.send(:all) unless model.is_a?(Array)
  
        # create a new array if its a single record
        model = [model] unless model.respond_to? :each
    
      Reportly::Engine.report(model, *fields)
    end
    

    def self.is_valid_klass?(klass)
      klass.descends_from_active_record? rescue false or klass.is_a?(Array)
    end        
    
  end
end

