class ScheduleCollectionTranslator
  attr_reader :schedule_groups

  def initialize(schedule_groups)
    @schedule_groups = schedule_groups
  end

  def translated_schedules
    schedule_groups.map do |schedule_group|
      schedule_group.schedules.reject(&:unknown_season?).map do |schedule|
        if schedule.block.blank?
          I18n.t("generic.schedule.season_types.#{schedule.season}").downcase
        else
          ScheduleTranslator.new(schedule).translate
        end
      end.to_sentence
    end
  end
end
