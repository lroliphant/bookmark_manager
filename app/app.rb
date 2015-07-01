require 'sinatra/base'
# require 'data_mapper'
require './app/data_mapper_setup.rb' # may need to remove this if heroku doesn't work...WHY OH WHY?

class BookmarkManager < Sinatra::Base

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title]) # 1. Create a link

    tags = params[:tag].split

    tags.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    # 3. Adding the tag to the link's DataMapper collection.

    # p link.tags

    link.save # 4. Saving the link.


    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  # redirect HP to /links
  get '/' do
    redirect '/links'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    User.create(email: params[:email],
                password: params[:password])
    redirect to('/links')
  end


end
