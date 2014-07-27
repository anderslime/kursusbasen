class CreateSpecialCourses < ActiveRecord::Migration
  def change
    create_table :special_courses do |t|
      t.references :student, index: true
      t.string :title
      t.float :ects_points

      t.timestamps
    end
  end
end
