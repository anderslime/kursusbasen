class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :course
      t.string :block

      t.timestamps
    end

    add_index :schedules, :course_id
  end
end
