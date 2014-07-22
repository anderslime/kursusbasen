class ScheduleSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :block, :season
end
