class AddOpenEducationToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :open_education, :boolean
  end
end
