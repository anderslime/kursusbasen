class Schedule < ActiveRecord::Base
  BLOCKS = ['1A', '2A', '3A', '4A', '5A', '1B', '2B', '3B', '4B', '5B']
  SEASONS = ['spring', 'autumn', 'summer', 'january', 'june', 'unknown']

  validates_inclusion_of :block, in: BLOCKS, unless: ->(s){ s.block.nil? }
  validates_inclusion_of :season, in: SEASONS

  validates_presence_of :season, :schedule_group_id

  class << self
    def including_block
      where.not(block: nil)
    end
  end

  def season_code
    {
      'autumn' => "E",
      'spring' => "F"
    }.fetch(season) { nil }
  end

  def unknown_season?
    season == "unknown"
  end
end
