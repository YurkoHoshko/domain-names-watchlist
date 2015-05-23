require "rubygems"
require "bundler/setup"
require "digest"
require "logger"
require "sinatra/asset_pipeline"


env = ENV["RACK_ENV"] || "development"
Bundler.require :default, env.to_sym


DB = Sequel.sqlite
DB.loggers << Logger.new($stdout)

DB.create_table :domain_name_records do
  primary_key :id
  column :domain_name, :string
  column :status, :string
  column :created_on, :datetime
  column :expires_on, :datetime
  column :contact_name, :string
  column :contact_email, :string 
  column :contact_phone, :string
end

DB.create_table :watchlist_items do
  primary_key :id
  column :watchlist_id, :string, :index => true
  column :domain_name_record_id , :string
end

Dir[File.expand_path('../models/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../services/*.rb', __FILE__)].each { |f| require f }
puts 