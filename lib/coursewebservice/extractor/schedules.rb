module Coursewebservice
  module Extractor
    class Schedules
      attr_reader :course_xml, :course

      def initialize(course_xml, course)
        @course_xml = course_xml
        @course     = course
      end

      def schedule_runs
        schedule_keys
      end

      def schedule_text
        danish_course_text_node && danish_course_text_node["Txt"]
      end

      def schedule_keys
        course_xml.xpath("//Course[@CourseCode='#{course_number}']//Class_Schedule").map do |class_schedule|
          class_schedule.children.map do |schedule_children|
            schedule_children["ScheduleKey"]
          end.compact.flatten.map do |schedule_key|
            extract_season_and_blocks(schedule_key).map do |season, block|
              Coursewebservice::Schedule.new(season, block)
            end
          end.flatten
        end.map do |class_schedule_schedules|
          Coursewebservice::CourseRun.new(class_schedule_schedules)
        end
      end

      def extract_season_and_blocks(schedule_string)
        extract_double_block_schedules(schedule_string).map do |schedule_string|
          if schedule_string =~ /\A([FE])(\d[AB])\z/
            [$1, $2]
          else
            [schedule_string, nil]
          end
        end
      end

      def extract_double_block_schedules(schedule_string)
        if schedule_string =~ /\A([FE]\d)\z/
          [$1 + "A", $1 + "B"]
        else
          [schedule_string]
        end
      end

      def danish_course_text_node
        @danish_course_text_node ||=
          course_xml.xpath("//Course[@CourseCode='#{course_number}']//Schedule_Txt[@Lang='da-DK']").first
      end

      def course_number
        course.course_number
      end
    end
  end

  class CourseRun
    def initialize(schedules)
      @schedules = schedules
    end

    def schedules
      if @schedules.any?
        @schedules
      else
        Array(Schedule.new("OutsideSchedule", nil))
      end
    end
  end

  class Schedule
    attr_reader :block, :scraped_season

    def initialize(scraped_season, block)
      @scraped_season = scraped_season
      @block          = block
    end

    def season
      map_schedule_season_from_danish
    end

    def outside_dtu_schedule?
      scraped_season == "OutsideSchedule"
    end

    private

    def map_schedule_season_from_danish
      {
        "F" => "spring",
        "E" => "autumn",
        "January" => "january",
        "June" => "june",
        "SummerSchool" => "summer",
        "OutsideSchedule" => 'unknown'
      }.fetch(scraped_season)
    end
  end
end
