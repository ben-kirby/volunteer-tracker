require 'pg'
require 'pry'

class Volunteer
  attr_accessor :id, :name, :project_id

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)

  end

  def self.all
    all_volunteers = []
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    returned_volunteers.each do |volunteer|
      id = volunteer.fetch('id').to_i
      name = volunteer.fetch('name')
      project_id = volunteer.fetch('project_id').to_i
      all_volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
    end
    return all_volunteers
  end

  def save
    save = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
    @id = save.first().fetch("id").to_i
  end

  def self.find(id)
    all_volunteers = DB.exec("SELECT * FROM volunteers WHERE id = #{id};")
    all_volunteers.each do |volunteer|
      id = volunteer.fetch('id').to_i
      name = volunteer.fetch('name')
      project_id = volunteer.fetch('project_id').to_i
      return Volunteer.new({:id => id, :name => name, :project_id => project_id})
    end
  end

  def self.all_volunteers_by_project(project_id)
    all_volunteers = []
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{project_id}")
    returned_volunteers.each do |volunteer|
      id = volunteer.fetch('id').to_i
      name = volunteer.fetch('name')
      project_id = volunteer.fetch('project_id').to_i
      all_volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
    end
    return all_volunteers
  end


  def ==(another_volunteer)
    self.name().==(another_volunteer.name()).&(self.id().==(another_volunteer.id()))
  end
end
