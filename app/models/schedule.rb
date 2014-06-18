class Schedule < ActiveRecord::Base
  BLOCKS = ['1A', '2A', '3A', '4A', '5A', '1B', '2B', '3B', '4B', '5B']
  SEASONS = ['spring', 'autumn', 'summer', 'january', 'june', 'unknown']

  validates_inclusion_of :block, in: BLOCKS, unless: ->(s){ s.block.nil? }
  validates_inclusion_of :season, in: SEASONS

  validates_presence_of :season, :schedule_group_id

  def unknown_season?
    season == "unknown"
  end
end
