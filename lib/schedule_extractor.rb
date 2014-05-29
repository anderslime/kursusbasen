class ScheduleExtractor
  attr_reader :page, :attribute_text

  def initialize(page, attribute_text)
    @page           = page
    @attribute_text = attribute_text
  end

  def schedule
    scraped_schedule_blocks.map do |schedule|
      extract_double_semester_schedules(sanitize_schedule(schedule))
    end.flatten.uniq
  end

  private

  def extract_double_semester_schedules(schedule)
    return schedule unless double_semester_schedule?(schedule)
    ["#{schedule}A", "#{schedule}B"]
  end

  def sanitize_schedule(schedule)
    schedule.upcase
  end

  def double_semester_schedule?(schedule)
    %r{F\d{1}\z}.match(schedule) or %r{E\d{1}\z}.match(schedule)
  end

  def scraped_schedule_blocks
    return [] if schedule_content.blank?
    schedule_content.scan(%r{([E|F]\d[A|B]?|Januar|Juni|januar|juni)}).to_a.map(&:first)
  end

  def schedule_content
    ColumnContentExtractor.new(page).content(attribute_text)
  end
end
