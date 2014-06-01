class CreateTeacherPages < ActiveRecord::Migration
  def change
    create_table :teacher_pages do |t|
      t.string :dtu_teacher_id
      t.text :page
      t.string :url

      t.timestamps
    end
  end
end
