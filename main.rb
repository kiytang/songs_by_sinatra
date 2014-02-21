#£
require 'sinatra'
# require 'sinatra/reloader' if development?
require 'slim'
require 'sass'

require './song'

configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

# connect to the database, creates a file development.db, that store all database info.
configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end

# This is a simple route handler that uses the scss to 
# process the styles view when
# the styles.css file is requested
get('/styles.css'){ scss :styles }

# the erb method is used with the argument
# :home  (name of view needs to eb a symbol)to indicate that 
# erb should be used to render the view called “home.”
get '/' do
	@title = "Home of Sinatra"
	slim :home 
end

get '/about' do
	@title = "All About This Website"
	slim :about
end

get '/contact' do
	@title = "Contact Informations"
	slim :contact
end

not_found do
	slim :not_found
end

get '/set/:name' do
	session[:name] = params[:name]
end

get '/get/hello' do
	"Hello #{session[:name]}"
end

get '/login' do
	slim :login
end

post '/login' do
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] |=true
		redirect to ('/songs')
	else
		slim :login
	end
end

get '/logout' do
	session.clear
	redirect to ('/login')
end


# __END__
# @@layout
# <% title= "Songs By Sinatra" %>
# <!doctype html>
# <html lang="en">
# <head>
# 	<title><%= title %></title>
# 	<meta charset="utf-8">
# </head>
# <body>
# 	<header>
# 		<h1><%= title %></h1>
# 		<nav>
# 			<ul>
# 				<li><a href="/" title="Home">Home</a><li</li>
# 				<li><a href="/about" title="About">About</a></li>
# 				<li><a href="/contact" title="Contact">Contact</a></li>
# 			</ul>
# 		</nav>	
# 	</header>
# 	<section>
# 		<%= yield %>
# 	</section>
# </body>
# </html>
# @@home
# <p>Welcome to this website all about the songs of the great Frank Sinatra</p>

# @@about
# <p>This site is a demonstration of how to build a website using Sinatra.</p>

# @@contact 
# <p>You can contact me by sending an email to dax at gmail.com</p>