class AddExamScheduleNote < ActiveRecord::Migration
  def change
    add_column :course_translations, :exam_schedule_note, :text
    add_column :course_translations, :schedule_note, :text
  end
end
