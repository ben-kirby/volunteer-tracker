require 'pg'
require 'pry'

class Project
  attr_accessor :id, :title

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
  end

  def self.all
    all_projects = []
    returned_projects = DB.exec("SELECT * FROM projects;")
    returned_projects.each do |project|
      id = project.fetch('id').to_i
      title = project.fetch('title')
      all_projects.push(Project.new({:id => id, :title => title}))
    end
    return all_projects
  end

  def save
    save = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = save.first().fetch("id").to_i
  end

  def self.find(id)
    if id == 0
      return false
    else
      all_projects = DB.exec("SELECT * FROM projects WHERE id = #{id};")
      all_projects.each do |project|
        title = project.fetch('title')
        id = project.fetch('id').to_i
        return Project.new({:id => id, :title => title})
      end
    end
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    @id = self.id
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = '#{self.id}';")
  end

  def volunteers
    Volunteer.all_volunteers_by_project(self.id)
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id}")
  end


  def ==(another_project)
    self.title().==(another_project.title()).&(self.id().==(another_project.id()))
  end
end
