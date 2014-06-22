class CreateQualifiedPrerequisites < ActiveRecord::Migration
  def change
    create_table :qualified_prerequisites do |t|
      t.references :course

      t.timestamps
    end

    create_table :courses_qualified_prerequisites do |t|
      t.references :course
      t.references :qualified_prerequisite
    end
  end
end
