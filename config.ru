require 'rubygems'
require 'bundler'
require 'data_mapper'
require 'dm-sqlite-adapter'

Bundler.require

require './where.rb'
require './models/checkin.rb'
require './models/person.rb'

DataMapper.setup(:default, "sqlite://#{Dir.pwd}/app.db")
DataMapper.finalize
DataMapper.auto_upgrade!

run App
