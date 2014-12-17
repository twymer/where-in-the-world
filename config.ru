require 'rubygems'
require 'bundler'
require 'data_mapper'
require 'dm-postgres-adapter'

Bundler.require

require './where.rb'
require './models/checkin.rb'
require './models/person.rb'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/where')
DataMapper.finalize
DataMapper.auto_upgrade!

run App
