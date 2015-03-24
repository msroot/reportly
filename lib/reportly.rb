require "reportly/version"
require "reportly/console_methods"

module Rails
  module ConsoleMethods
    # Creates a  +:report+ method helper exposed to rails console
    #
    # Accepts <tt>ActiveRecord::Relation</tt> and <tt>ActiveRecord::Base</tt> objects 
    # and generated a table
    #
    #Example:
    #   report User
    # or 
    #   report Post.all
    # Note <tt>:r</tt> its the alias method for <tt>:report</tt>
    # 
    # Usage:
    #   report(records)  # displays report with all fields
    #   report(records, :field1, :field2, ...) # displays report with given fields
    #
    # ==== Options
    # * <tt>items</tt>   - The ActiveRecord objects
    # * <tt>fields</tt>  - Filter only the given fields
    
    def report(model, *fields)
      Reportly::ConsoleMethods.report(model, *fields)
    end
    
    alias_method :r, :report
  end
end
