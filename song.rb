# the first gem dm-core is the main DataMapper gem
# dm-migrations is an extension-to provide extra functionality
require 'dm-core'
require 'dm-migrations'

# onnect to the database, creates a file development.db, that store all database info.
DataMapper.setup(:default, "sq;ite3://#{Dir.pwd}/development.db")