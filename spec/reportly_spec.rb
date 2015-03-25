require 'spec_helper'
require 'active_record'
require 'rails/console/helpers'

REPORTLY = Reportly::ConsoleMethods
    
def run_migrations!
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")  
  
  m = ActiveRecord::Migration.new
  m.verbose = false  
  m.create_table :users do |t| 
    t.string :name
  end
  
end


def create_users_class
  run_migrations!
  user = Class.new(ActiveRecord::Base)
  user.table_name =  :users
  2.times {user.create}
  user.all
end



describe Reportly do
  
  let(:irb_context) {Object.new.extend(Rails::ConsoleMethods)}
  let(:users) {create_users_class}
  
  let(:user) {
    user = Class.new(ActiveRecord::Base)
    user.table_name =  :users
    user
  }
  
    
  it 'respond to report' do
    expect(irb_context).to respond_to(:report)
    expect(irb_context).to respond_to(:r)
  end
  
  it 'raise error for not active recods' do
    [Hash, Object].each do |o|
      expect{irb_context.report o.new}.to raise_error(REPORTLY::ReportlyNotValid)
    end
  end
  
  it 'not raise error on users' do
    expect{irb_context.report users}.to_not raise_error
  end
  
  it 'not raise error on user class' do
    expect{irb_context.report user}.to_not raise_error
  end


  it 'accepting active record array ' do
    expect{irb_context.report users.first(2)}.to_not raise_error
  end
  
  it 'accepting active record array ' do
    expect{irb_context.report users.where(id: 1)}.to_not raise_error
  end
  
  
  it 'passing fields ' do
    expect{irb_context.report users, :id, :name}.to_not raise_error
  end
  
  it 'respond to each' do
    [user, users, users.first(2), users.first].each do |valid|
      expect(REPORTLY.make_array_for(valid).respond_to?(:each)).to be true
    end
  end


  it 'should be valid ' do
    [user, users, users.first(2), users.first].each do |valid|

      model = REPORTLY.make_array_for(valid)
        
      expect(REPORTLY.is_valid_klass?(model)).to be true 
    end
  end
    
  it 'should not raise in validation ' do
    expect(REPORTLY.is_valid_klass?(nil)).to be false 
    expect{REPORTLY.is_valid_klass?(nil)}.to_not raise_error
  end
    
    
    
  it 'should not be valid ' do
    [String, Set, Hash, Class, Array].each do |klass|
      expect(REPORTLY.is_valid_klass?(klass.new)).to be false 
      expect{REPORTLY.is_valid_klass?(klass.new)}.to_not raise_error
    end
      
    ["", [], {}].each do |klass|
      expect(REPORTLY.is_valid_klass?(klass)).to be false 
      expect{REPORTLY.is_valid_klass?(klass)}.to_not raise_error
    end
      
  end


  let(:users_table) {
    t = []
    t << "+----+------+"
    t << "| id | name |"
    t << "+----+------+"
    t << "| 1  |      |"
    t << "| 2  |      |"
    t << "+----+------+"
    t << "2 rows in set"
    t
  }

  let(:user_table) {
    t = []
    t << "+----+"
    t << "| id |"
    t << "+----+"
    t << "| 1  |"
    t << "+----+"
    t << "1 rows in set"
    t
  }

  # Not thread safe 
  it 'all table' do
    irb_context.report(users)
    expect(REPORTLY.results).to eq(users_table)
  end
    
  it 'using first' do
    irb_context.report(users.first, :id)
    expect(REPORTLY.results).to eq(user_table)
  end
    
  it 'using find' do
    irb_context.report(users.find(1), :id)
    expect(REPORTLY.results).to eq(user_table)
  end
  
end
