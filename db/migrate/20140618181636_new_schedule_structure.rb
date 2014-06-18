class NewScheduleStructure < ActiveRecord::Migration
  def change
    create_table :schedule_groups do |t|
      t.references :course

      t.timestamps
    end

    add_index :schedule_groups, :course_id

    remove_column :schedules, :course_id, :integer
    add_column :schedules, :schedule_group_id, :integer
    add_column :schedules, :outside_dtu_schedule, :boolean
    add_column :schedules, :season, :string

    add_index :schedules, :schedule_group_id
  end
end
