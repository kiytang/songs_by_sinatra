# the first gem dm-core is the main DataMapper gem
# dm-migrations is an extension-to provide extra functionality
require 'dm-core'
require 'dm-migrations'

# onnect to the database, creates a file development.db, that store all database info.
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Song
	include Datamapper::Resource
	property :id, Serial
	property :title, String
	property :lyrics, Text
	property :length, Integer
	property :released_on, Date
end

DataMapper.finalize 