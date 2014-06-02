class ScheduleSeasonBlockExtractor
  attr_reader :page, :schedule_blocks

  def initialize(page, schedule_blocks)
    @page            = page
    @schedule_blocks = schedule_blocks
  end

  def schedule_season_block
    # TODO: extract season (forår, efterår, januar, juni)
  end
end
