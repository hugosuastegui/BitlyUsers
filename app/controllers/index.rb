before '/users/:id' do
  unless session[:id]
    redirect to "/"
  end
end
#en esta forma solo se utilizan 3 vistas, de otra forma se podria
#implementar 5 vistas para cada caso: login,logout,registrer,invalid y valid registrer
#esto se hace al crear mas vistas en el view
get '/' do

    erb :index
end

get '/users/:id' do

  # u = User.find(params[:id])
  erb :secret
end


post '/register' do
  name = params[:name]
  email = params[:email]
  password = params[:password]
  u = User.new(name: name, email: email, password: password)
  if u.save 
    @bulean = true
    session[:id] = u.id
    redirect to ("/users/#{u.id}")
  end
end

post '/login' do
  @error_message = ""
  email = params[:email]
  password = params[:password]
#buscar sio existe el usuario
  user = User.authenticate(email, password)
  if user 
      session[:id] = user.id
     erb :secret
  else
#obtener id y email para crear sesión
  @error_message = "Usuario Inválido"
    erb :index
  end
end


get '/logout' do
  session.clear
  @bulean2 = true
  erb :index
end

# -----------------------------------

get '/correcto' do
  if Url.last.id == 0
    @all_urls = Url.last
  else
  @all_urls = Url.where(user_id: current_user.id)
  end
  erb :words
end

post '/urls' do
  user_input = params[:user_input]
  # user = User.find_by(name: session[:name])
  if session[:id] == nil
    Url.create(url_long: user_input, user_id: 0)
  else  
   Url.create(url_long: user_input, user_id: current_user.id)
  end
  redirect to '/correcto'
end

get '/:short_url' do
  user_input = params[:short_url]
  # redirige a la URL original
  puts "*" * 50
  u = Url.find_by(url_short: user_input)
  u.click_count += 1
  u.save
  redirect to ("#{u.url_long}")
end