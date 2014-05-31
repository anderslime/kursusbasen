class Schedule < ActiveRecord::Base
  validates_inclusion_of :block,
    in: [
      'E1A', 'E2A', 'E3A', 'E4A', 'E5A', 'F1A', 'F2A','F3A', 'F4A', 'F5A',
      'E1B', 'E2B', 'E3B', 'E4B', 'E5B', 'F1B', 'F2B', 'F3B', 'F4B', 'F5B',
      'Januar', 'Juni'
    ]

  validates_uniqueness_of :block, :scope => :course_id
  validates_presence_of :block, :course_id
end
