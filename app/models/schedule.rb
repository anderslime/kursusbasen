class Schedule < ActiveRecord::Base
  BLOCKS = ['1A', '2A', '3A', '4A', '5A', '1B', '2B', '3B', '4B', '5B']
  SEASONS = ['spring', 'autumn', 'summer', 'january', 'june', 'unknown']

  validates_inclusion_of :block, in: BLOCKS, unless: ->(s){ s.block.nil? }
  validates_inclusion_of :season, in: SEASONS

  DAY_OF_WEEK_BLOCK_MAPPING = {
    ['1A', '2A'] => 1,
    ['3A', '4A'] => 2,
    ['5A', '5B'] => 3,
    ['2B', '1B'] => 4,
    ['4B', '3B'] => 5
  }

  TIME_INTERVAL_MAPPING = {
    ['1A', '3A', '5A', '2B', '4B'] => TimeInterval.new("10:00", "12:00"),
    ['2A', '4A', '5B', '1B', '3B'] => TimeInterval.new("13:00", "17:00")
  }

  delegate :from, :to, to: :time_interval, prefix: true

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

  def day_of_week
    DAY_OF_WEEK_BLOCK_MAPPING.select {|blocks, day_of_week|
      blocks.include?(block)
    }.values.first
  end

  def time_interval
    TIME_INTERVAL_MAPPING.select {|blocks, time_interval|
      blocks.include?(block)
    }.values.first
  end
end
