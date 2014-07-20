class CreateCoursePlannings < ActiveRecord::Migration
  def change
    create_table :course_plannings do |t|
      t.references :student, index: true
      t.references :course, index: true

      t.timestamps
    end
    add_index :course_plannings, [:student_id, :course_id], unique: true
  end
end
