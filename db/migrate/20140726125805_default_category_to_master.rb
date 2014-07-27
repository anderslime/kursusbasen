class DefaultCategoryToMaster < ActiveRecord::Migration
  def change
    change_column :course_plannings, :category, :string, default: 'master'
  end
end
