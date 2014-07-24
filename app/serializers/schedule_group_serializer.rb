class ScheduleGroupSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id
  has_many :schedules
end
