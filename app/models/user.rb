# bcrypt will generate the password hash
require 'bcrypt' # make sure 'bcrypt' is in your Gemfile

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String


end
