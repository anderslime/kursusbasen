class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :student_number

      t.timestamps
    end

    add_index :students, :student_number, :unique => true
  end
end
