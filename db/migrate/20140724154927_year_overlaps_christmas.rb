class YearOverlapsChristmas < ActiveRecord::Migration
  def change
    change_column :course_plannings, :year, :string
  end
end
