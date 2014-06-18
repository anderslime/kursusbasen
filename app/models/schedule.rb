class Schedule < ActiveRecord::Base
  BLOCKS = ['1A', '2A', '3A', '4A', '5A', '1B', '2B', '3B', '4B', '5B']
  SEASONS = ['spring', 'autumn', 'summer', 'january', 'june']
  validates_inclusion_of :block, in: BLOCKS
  validates_inclusion_of :season, in: SEASONS

  validates_presence_of :season, :schedule_group_id

  def spring?
    block[0] == "F"
  end

  def autumn?
    block[0] == "E"
  end
end
