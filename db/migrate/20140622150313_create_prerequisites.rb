class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites do |t|
      t.references :course
      t.string :prerequisite_type

      t.timestamps
    end

    create_table :courses_prerequisites do |t|
      t.references :course
      t.references :prerequisite
    end
  end
end
