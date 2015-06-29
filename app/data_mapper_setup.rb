require 'data_mapper'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager")

require './app/models/link'

DataMapper.finalize

DataMapper.auto_upgrade!
