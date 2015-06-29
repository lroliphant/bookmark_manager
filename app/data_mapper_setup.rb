require 'data_mapper'
require './app/models/link'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager")

DataMapper.finalize

DataMapper.auto_upgrade!
