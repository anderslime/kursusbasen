class DefaultOpenEducationToFalse < ActiveRecord::Migration
  def change
    change_column :courses, :open_education, :boolean, :default => false
  end
end
