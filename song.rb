# the first gem dm-core is the main DataMapper gem
# dm-migrations is an extension-to provide extra functionality
require 'dm-core'
require 'dm-migrations'

# connect to the database, creates a file development.db, that store all database info.
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Song
	include DataMapper::Resource  #forgot to capialise the 'm' in mapper
	property :id, 		     Serial
	property :title, 	     String
	property :lyrics,   	 Text
	property :length, 		 Integer
	property :released_on, Date

	def released_on=date
		super Date.strptime(date, '%m/%d/%Y')
	end

	DataMapper.finalize
end 
# this route handler creates an empty song object and then displays the 
# new_song view
get '/songs/new' do
	@song = Song.new
	slim :new_song
end

get '/songs/:id' do
	@song = Song.get(params[:id])
	slim :show_song
end

post '/songs' do
	song = Song.create(params[:song])
	redirect to("/songs/#{song.id}")
end

get '/songs/:id/edit' do
	@song = Song.get(params[:id])
	slim :edit_song
end

put '/songs/:id' do
	song = Song.get(params[:id])
	song.update(params[:song])
	redirect to ("/songs/#{song.id}")
end

delete '/songs/:id' do
	Song.get(params[:id]).destroy
	redirect to('/songs')
end
