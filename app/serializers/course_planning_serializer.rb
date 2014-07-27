class CoursePlanningSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :year, :semester_season_start, :category, :programme
  has_one :student
  has_one :course, polymorphic: true
  has_one :schedule_group
end
