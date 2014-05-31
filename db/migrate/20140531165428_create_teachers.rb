class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :location
      t.string :phone
      t.string :email
      t.string :dtu_teacher_id

      t.timestamps
    end
  end
end
