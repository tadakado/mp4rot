# encoding: utf-8

## top directory of movie files

TOP='/home/mp4rot/app/movie'

##### Web server #####

require 'rubygems'
require 'sinatra'
require 'haml'

set :bind, '0.0.0.0'

set :public_folder, TOP

get '/' do
  redirect '/view/'
end

get '/view' do
  redirect '/view/'
end

get '/view/*' do
  @top = TOP
  @entry = params[:splat].first
  redirect "/#{@entry}" if @entry[/\.mp4$/i]
  @files = Dir.entries(TOP + '/' + @entry).select{|x| x[0] != "."}.sort
  haml :view
end

get '/thumb/*' do
  file = TOP + '/' + params[:splat].first
  content_type 'image/jpeg'
  `ffmpeg -v quiet -i #{file} -f image2 -ss 0.01 -frames:v 1 -`
end

get '/conv/*' do
  file = TOP + '/' + params[:splat].first
  `exiftool -overwrite_original -P -rotation=#{params[:rotation]} #{file}`
  redirect back
end
