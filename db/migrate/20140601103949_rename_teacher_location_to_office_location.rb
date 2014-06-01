class RenameTeacherLocationToOfficeLocation < ActiveRecord::Migration
  def change
    rename_column :teachers, :location, :office_location
  end
end
