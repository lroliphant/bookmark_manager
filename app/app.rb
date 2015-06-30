require 'sinatra/base'

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

    tag = Tag.create(name: params[:tag]) # 2. Create a tag for the link
    link.tags << tag # 3. Adding the tag to the link's DataMapper collection.
    link.save # 4. Saving the link.

    redirect to('/links')
  end


end
