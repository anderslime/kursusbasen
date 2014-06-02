class ScheduleSeasonBlocksValidator < ActiveModel::Validator
  SCHEDULE_SEASON_BLOCKS = ["spring", "autumn", "january", "june", "summer"]

  attr_reader :course

  def validate(course)
    @course = course
    validate_season_blocks
  end

  private

  def validate_season_blocks
    if any_invalid_season_blocks?
      errors.add(:schedule_season_blocks, :block_not_in_list)
    end
  end

  def any_invalid_season_blocks?
    invalid_season_blocks.any?
  end

  def invalid_season_blocks
    course.schedule_season_blocks.map do |block|
      invalid?(block)
    end
  end

  def invalid?(block)
    !SCHEDULE_SEASON_BLOCKS.include?(block)
  end
end
