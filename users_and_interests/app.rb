require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @users = YAML.load_file('users.yaml')
  @num_users = @users.keys.size
  @num_interests = count_interests
end

get "/" do
  redirect "/users"
end

get "/user/:username" do
  @current_user = params[:username].to_sym
  @current_user_info = @users[@current_user]

  @other_users = @users.reject { |user, _| user == @current_user }
  erb :user
end

get "/users" do
  erb :home
end

helpers do
  def count_interests
    @users.values.reduce(0) { |sum, info_hash| sum + info_hash[:interests].size }
  end
end

# YAML output -
#{:jamy=>{:email=>"jamy.rustenburg@gmail.com", :interests=>["woodworking", "cooking", "reading"]},
# :nora=>{:email=>"nora.alnes@yahoo.com", :interests=>["cycling", "basketball", "economics"]},
# :hiroko=>{:email=>"hiroko.ohara@hotmail.com", :interests=>["politics", "history", "birding"]}}