require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('pry')

DB = PG.connect({:dbname => 'volunteer'})

get '/' do

  erb(:index)
end
