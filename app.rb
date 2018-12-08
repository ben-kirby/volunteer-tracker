require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/volunteer')
require('./lib/project')
require('pry')

DB = PG.connect({:dbname => 'volunteer_tracker'})

get ('/') do
  erb(:index)
end

get ('/add_volunteer') do
  @volunteers = Volunteer.all
  @projects = Project.all
  erb(:add_volunteer)
end

post ('/add_volunteer') do
  @projects = Project.all
  @volunteers = Volunteer.all

  name = params.fetch('name')
  project_id = params.fetch('project_id')
  new_volunteer = Volunteer.new({:id => nil, :name => name, :project_id => project_id})
  new_volunteer.save

  erb(:add_volunteer)
end

get ('/view_volunteer') do
  @disp = false
  @volunteers = Volunteer.all
  erb(:view_volunteer)
end

post ('/view_volunteer') do
  @disp = true
  id = params.fetch('id')
  @volunteer = Volunteer.find(id)
  @project = Project.find(@volunteer.project_id)
  @volunteers = Volunteer.all
  erb(:view_volunteer)
end

get ('/add_project') do
  @projects = Project.all
  erb(:add_project)
end

post ('/add_project') do
  title = params.fetch('title')
  new_project = Project.new({:id => nil, :title => title})
  new_project.save

  @projects = Project.all
  erb(:add_project)
end

get ('/edit_project') do
  @disp = 0
  @projects = Project.all

  erb(:edit_project)
end

get ('/edit_project/:id') do
  @disp = 1
  @projects = Project.all
  @project = Project.find(params.fetch('id'))
  erb(:edit_project)
end

patch("/edit_project/:id") do
  title = params.fetch("title")
  @project = Project.find(params.fetch("id").to_i())
  @project.update({:title => title})
  @projects = Project.all
  @disp = 0
  erb(:edit_project)
end

delete("/edit_project/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete()
  @projects = Project.all()
  @disp = 0
  erb(:edit_project)
end

get ('/manage_assignments') do
  @projects = Project.all
  @volunteers = Volunteer.all

  erb(:manage_assignments)
end

post ('/manage_assignments') do
  project_id = params.fetch('project').to_i

  @volunteer = Volunteer.find(params.fetch('name').to_i)
  @volunteer.update({:project_id => project_id})

  @volunteers = Volunteer.all
  @projects = Project.all

  erb(:manage_assignments)
end
