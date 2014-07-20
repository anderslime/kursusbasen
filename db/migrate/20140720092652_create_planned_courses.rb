class CreatePlannedCourses < ActiveRecord::Migration
  def change
    create_table :planned_courses do |t|
      t.references :student, index: true
      t.references :course, index: true

      t.timestamps
    end
    add_index :planned_courses, [:student_id, :course_id], unique: true
  end
end
