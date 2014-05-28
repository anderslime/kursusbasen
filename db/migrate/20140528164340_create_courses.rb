class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.integer :course_number, :null => false
      t.string :language
      t.float :ects_points
      t.integer :institute_id
      t.string :homepage
      t.string :exam_duration

      t.timestamps
    end

    add_index :courses, :course_number

    Course.create_translation_table!(
      :title             => :string,
      :teaching_form     => :text,
      :duration          => :string,
      :participant_limit => :string,
      :registration      => :string,
      :course_objectives => :text,
      :exam_schedule     => :text,
      :learn_objectives  => :text,
      :content           => :text,
      :litteratur        => :text,
      :remarks           => :text,
      :top_comment       => :text,
      :former_course     => :string,
      :exam_form         => :text,
      :exam_aid          => :string,
      :evaluation_form   => :string
    )
  end

  def down
    drop_table :courses
    Course.drop_translation_table!
  end
end
