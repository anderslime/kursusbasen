class CreateCoursePages < ActiveRecord::Migration
  def change
    create_table :course_pages do |t|
      t.integer :course_number, :null => false
      t.text :page, :null => false

      t.timestamps
    end

    add_index :course_pages, :course_number
  end
end
