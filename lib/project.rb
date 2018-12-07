require 'pg'
require 'pry'

class Project
  attr_accessor :id, :title

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
  end

  def all
    all_projects = []
    returned_projects = DB.exec("SELECT * FROM projects;")
    returned_projects.each do |project|
      id = project.fecth('id').to_i
      title = project.fetch('title')
      all_projects.push(Project.new({:id => id, :title => title}))
    end
    return all_projects
  end

  def save
    save = DB.exec("INSERT INTO projects (name) VALUES ('#{@title}') RETURNING id;")
    @id = save.first().fetch("id").to_i
  end


end
