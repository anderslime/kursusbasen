class AddUrlToCoursePages < ActiveRecord::Migration
  def change
    add_column :course_pages, :url, :string
  end
end
