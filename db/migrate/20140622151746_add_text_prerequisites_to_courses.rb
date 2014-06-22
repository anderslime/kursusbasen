class AddTextPrerequisitesToCourses < ActiveRecord::Migration
  def change
    add_column :course_translations, :qualified_prerequisites_text, :text
    add_column :course_translations, :mandatory_prerequisites_text, :text
  end
end
