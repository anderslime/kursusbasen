class AddScheduleSeasonBlockToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :schedule_season_blocks, :text
  end
end
