require 'data_mapper'

# This class corresponds to a table in the database
# We can use it to manipulate the data
class Link

  # adds datamapper functionality to this class
  include DataMapper::Resource

  # these property declarations set the column headers in the Link table
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :title,  String
  property :url,    String

  has n, :tags, through: Resource # creates associations - many-to-many relationship - through a join table - representing every combination of a student and a coach/ links and tags - links_tags table

end

# ORM does this - creating relationships between databases
