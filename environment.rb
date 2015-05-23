require "rubygems"
require "bundler/setup"
require "digest"
require "logger"
require "sinatra/asset_pipeline"


env = ENV["RACK_ENV"] || "development"
Bundler.require :default, env.to_sym


DB = ENV['DATABASE_URL'] ? Sequel.connect(ENV['DATABASE_URL']) : Sequel.sqlite
DB.loggers << Logger.new($stdout)

unless DB.table_exists?(:domain_name_records)
  DB.create_table :domain_name_records do
    primary_key :id
    column :domain_name, String
    column :status, String
    column :created_on, DateTime
    column :expires_on, DateTime
    column :contact_name, String
    column :contact_email, String 
    column :contact_phone, String
  end
end

unless DB.table_exists?(:watchlist_items)
  DB.create_table :watchlist_items do
    primary_key :id
    column :watchlist_id, String, :index => true
    column :domain_name_record_id , Integer
  end
end

Dir[File.expand_path('../models/*.rb', __FILE__)].each { |f| require f }
Dir[File.expand_path('../services/*.rb', __FILE__)].each { |f| require f }