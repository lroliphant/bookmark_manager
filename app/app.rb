require 'sinatra/base'
require './app/data_mapper_setup.rb'

class BookmarkManager < Sinatra::Base

  enable :sessions
  set :sessions_secret, 'super secret'


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

  #redirect HP to /links
  get '/' do
    redirect '/links'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect to('/')
  end

  # helpers do
  #   def current_user
  #     User.get(session[:user_id])
  #   end
  # end

  # refactored method with lazy initialization
  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end


end
