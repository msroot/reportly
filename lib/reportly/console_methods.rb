require "reportly/engine"

module Reportly
  module ConsoleMethods
    extend self    
    
    class ReportlyNotValid < StandardError; end
    
    def report(model, *fields)
      
      model = make_array_for(model)
      
      validate(model)
      report = Reportly::Engine.report(model, *fields)
      @results = report
      puts report.join("\n")
    end
    
    def results
      @results
    end

    def make_array_for(model)
      # report User.first
      # 2.1.3 :003 >   User.first.class
      #  => User(id: uuid, partner_id: uuid, created_at: datetime, updated_at: datetime)
      model = [model] if model.class.superclass == ActiveRecord::Base
      # report User
      # 2.1.3 :004 > User.class
      #  => Class
      model = model.send(:all) if model.class.name == 'Class' and model.respond_to? :all
      
      # User.all.first(2) and User.where(name: 'yannis') are kind of arrays and respond to :each
      
      # 2.1.3 :006 > User.first(2).class
      #  => Array
       
      # 2.1.3 :013 > User.all.class
      #  => User::ActiveRecord_Relation
      model
      
    end
    
    def validate(model)
      raise ReportlyNotValid, "Reportly accepts only ActiveRecord Objects" unless is_valid_klass?(model)
    end

    # accepts Array or a ActiveRecord_Relation
    # Should respond_to? :each and be descend from active record
    def is_valid_klass?(model)
      model.first.class.descends_from_active_record? rescue false and  model.respond_to? :each
    end        

  end
end
