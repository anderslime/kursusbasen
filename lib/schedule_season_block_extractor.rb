class ScheduleSeasonBlockExtractor
  attr_reader :schedule_note, :schedule_blocks

  def initialize(schedule_note, schedule_blocks)
    @schedule_note   = schedule_note
    @schedule_blocks = schedule_blocks
  end

  def schedule_season_block
    {
      'january' => lambda { january? },
      'june'    => lambda { june? },
      'autumn'  => lambda { autumn? },
      'spring'  => lambda { spring? },
      'summer'  => lambda { summer? }
    }.keep_if {|block, matcher| matcher.call }.keys
  end

  private

  def summer?
    schedule_note_match?(/sommerkursus/) ||
      schedule_note_match?(/summer school/)
  end

  def january?
    schedule_note_match?(/januar/)
  end

  def june?
    schedule_note_match?(/juni/)
  end

  def autumn?
    first_letter_of_schedule_blocks.include?("E") ||
      schedule_note_match?(/efterår/)
  end

  def spring?
    first_letter_of_schedule_blocks.include?("F") ||
      schedule_note_match?(/forår/)
  end

  def schedule_note_match?(pattern)
    return false if schedule_note.nil?
    !!(schedule_note.downcase =~ pattern)
  end

  def first_letter_of_schedule_blocks
    @first_letter_of_schedule_blocks ||= schedule_blocks.map(&:block).map(&:first)
  end
end
