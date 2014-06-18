class CourseScheduleView
  attr_reader :view_context, :course_schedules

  def initialize(view_context, course_schedules)
    @view_context           = view_context
    @course_schedules       = course_schedules
  end

  def day_header(day)
    view_context.content_tag(
      :th,
      one_letter_day_abbreviation(day),
      title: day_abbreviation(day)
    )
  end

  def block_table_column(schedule_block)
    view_context.content_tag(
      :td,
      schedule_block,
      class: block_css_class(schedule_block)
    )
  end

  private

  def block_css_class(schedule_block)
    season_code_to_css_class_mapping.fetch(
      sorted_season_codes_included(schedule_block)
    ) { nil }
  end

  def season_code_to_css_class_mapping
    {
      'E'  => 'autumn',
      'F'  => 'spring',
      'EF' => 'allyear'
    }
  end

  def sorted_season_codes_included(schedule_block)
    course_schedules.select {|schedule|
      schedule.block == schedule_block
    }.map(&:season_code).sort.join
  end

  def day_abbreviation(day)
    I18n.t('date.abbr_day_names')[day_number(day)]
  end

  def one_letter_day_abbreviation(day)
    I18n.t('date.abbr_day_names')[day_number(day)].capitalize[0]
  end

  def day_number(day)
    {
      'monday'    => 1,
      'tuesday'   => 2,
      'wednesday' => 3,
      'thursday'  => 4,
      'friday'    => 5
    }.fetch(day)
  end
end
