class ChangeDtuInstituteIdToString < ActiveRecord::Migration
  def change
    change_column :institutes, :dtu_institute_id, :string
  end
end
