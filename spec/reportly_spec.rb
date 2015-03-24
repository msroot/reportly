require 'spec_helper'
require 'active_record'
require 'rails/console/helpers'

NAMESPACE = Reportly::ConsoleMethods
    
def run_migrations!
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")  
  
  m = ActiveRecord::Migration.new
  m.verbose = false  
  m.create_table :users do |t| 
    t.string :name
  end
  
end


def create_user_class
  run_migrations!
  user = Class.new(ActiveRecord::Base)
  user.table_name =  :users
  2.times {user.create}
  user
end



describe Reportly do
  
  let(:irb_context) {Object.new.extend(Rails::ConsoleMethods)}
  let(:users) {create_user_class}
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
    [Class, Hash, Object].each do |o|
      expect{irb_context.report o.new}.to raise_error(NAMESPACE::ReportlyNotValid)
    end
  end
  
  it 'not raise error' do
    expect{irb_context.report users.all}.to_not raise_error
  end
  
  it 'not raise error on class' do
    expect{irb_context.report users}.to_not raise_error
    expect{irb_context.report user}.to_not raise_error
  end
  
  it 'should call :all' do
    expect(irb_context.report users).to equal(irb_context.report users.all)
  end

  it 'accepting active record array ' do
    expect{irb_context.report users.all.first(2)}.to_not raise_error
  end
  
  it 'accepting active record array ' do
    expect{irb_context.report users.where(id: 1)}.to_not raise_error
  end
  
  
  it 'passing fields ' do
    expect{irb_context.report users, :id, :name}.to_not raise_error
  end


  describe "Validations" do

    it 'should be valid ' do
      [users, users.all, users.all.first(2)].each do |valid|
        expect(NAMESPACE.is_valid_klass?(valid)).to be true 
      end
    end
    
    it 'should not be valid ' do
      [Hash.new, Class.new].each do |valid|
        expect(NAMESPACE.is_valid_klass?(valid)).to be false 
      end
    end
   
  end
end
