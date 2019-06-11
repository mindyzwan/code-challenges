require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @file_names = Dir.glob("public/*").map { |file| File.basename(file) }.sort
  @file_names = @file_names.reverse! if params[:sort_desc]
  if params.keys.include?("sort_asc")
    @sort_order = ["Sort Descending", :sort_desc]
  elsif params.keys.include?("sort_desc")
    @sort_order = ["Sort Ascending", :sort_asc]
  else
    @sort_order = ["Sort Descending", :sort_desc]
  end
  erb :home
end