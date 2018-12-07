require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('./lib/project')
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
  @volunteer = nil
  @volunteers = Volunteer.all
  erb(:view_volunteer)
end

post '/view_volunteer' do
  id = params.fetch('id')
  @volunteer = Volunteer.find(id)
  @project = Project.find(@volunteer.project_id)
  @volunteers = Volunteer.all
  erb(:view_volunteer)
end

get '/add_project' do
  @projects = Project.all
  erb(:add_project)
end

post '/add_project' do
  title = params.fetch('title')
  new_project = Project.new({:id => nil, :title => title})
  new_project.save

  @projects = Project.all
  erb(:add_project)
end

get '/edit_project' do
  @projects = Project.all

  erb(:edit_project)
end

post '/edit_project/:id' do
  @projects = Project.all
  @project = Project.find(params.fetch('id'))
  erb(:edit_project)
end
