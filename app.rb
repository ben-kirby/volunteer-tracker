require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('pry')

DB = PG.connect({:dbname => 'volunteer_tracker'})

get '/' do
  erb(:index)
end

get '/add_volunteer' do
    @volunteers = Volunteer.all
    erb(:add_volunteer)
end

post '/add_volunteer' do
  name = params.fetch('name')
  new_volunteer = Volunteer.new({:id => nil, :name => name, :project_id => 0})
  new_volunteer.save
  @volunteers = Volunteer.all
  erb(:add_volunteer)
end

get '/view_volunteer' do
  @volunteers = Volunteer.all
  erb(:view_volunteer)
end

post '/view_volunteer' do
  @volunteers = Volunteer.all
  erb(:view_volunteer)
end
