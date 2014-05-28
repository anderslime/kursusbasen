class Course < ActiveRecord::Base
  translates :title, :teaching_form, :duration, :participant_limit, :registration,
             :course_objectives, :exam_schedule, :learn_objectives, :content,
             :litteratur, :remarks, :top_comment, :former_course, :exam_form,
             :exam_aid, :evaluation_form
end
