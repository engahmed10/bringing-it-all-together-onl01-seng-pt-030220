require 'sqlite3'
require_relative '../lib/dog'

DB = {:conn => SQLite3::Database.new("db/dogs.db")}


Dog.new(name:"Pop",breed:"pufff")
