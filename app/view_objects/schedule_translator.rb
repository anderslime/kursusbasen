class ScheduleTranslator
  attr_reader :schedule

  def initialize(schedule)
    @schedule = schedule
  end

  def translate
    [translated_day_of_week, translated_time_interval, translated_seasons].join(", ")
  end

  private

  def translated_day_of_week
    I18n.t("date.abbr_day_names")[schedule.day_of_week]
  end

  def translated_time_interval
    [time_interval_from, time_interval_to].join(" - ")
  end

  def time_interval_from
    hour(schedule.time_interval_from)
  end

  def time_interval_to
    hour(schedule.time_interval_to)
  end

  def hour(time_string)
    I18n.l(Time.parse(time_string), format: :hour_short)
  end

  def translated_seasons
    I18n.t("generic.schedule.season_types.#{schedule.season}").downcase
  end
end
