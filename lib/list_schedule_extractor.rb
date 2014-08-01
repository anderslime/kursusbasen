class ListScheduleExtractor
  COURSE_LINK_REGEX = /\d{4}-\d{4}\/(\w{5})\.aspx\?menulanguage=.*/

  def courses
    course_table_rows.map do |row|
      course_number = extract_course_number(row)
      schedule_string = extract_schedule_string(row)
      course_runs = extract_course_run_schedules(schedule_string).map do |run_string|
        CourseRun.new(extract_schedules(run_string))
      end
      Course.new(course_number, course_runs)
    end
  end

  private

  def extract_schedules(run_string)
    run_string.gsub(",", "og").split("og").map(&:strip).map do |schedule_string|
      extract_season_and_blocks(schedule_string).map do |season, block|
        Schedule.new(season, block)
      end
    end.flatten
  end

  def extract_season_and_blocks(schedule_string)
    extract_double_block_schedules(schedule_string).map do |schedule_string|
      if schedule_string =~ /\A([FE])(\d[AB]).*/
        [$1, $2]
      else
        [schedule_string, nil]
      end
    end
  end

  def extract_double_block_schedules(schedule_string)
    if schedule_string =~ /\A([FE]\d)[^AB].*/
      [$1 + "A", $1 + "B"]
    else
      [schedule_string]
    end
  end

  def extract_course_run_schedules(schedule_string)
    schedule_string.split("eller").map(&:strip)
  end

  def extract_schedule_string(row)
    row.at_css("strong").text.split("|").last
  end

  def extract_course_number(row)
    COURSE_LINK_REGEX.match(row.at_css("a")[:href])[1]
  end

  def course_table_rows
    get_course_list_page.search("table")[15].search("tr").select do |row|
      row.at_css("a") && row.at_css("a")[:href] =~ COURSE_LINK_REGEX
    end
  end

  def get_course_list_page
    if File.exists?("course_list_page.html")
      Nokogiri::HTML(IO.read("course_list_page.html"))
    else
      page = agent.get(course_list_url)
      File.open("course_list_page.html", "wb") {|f| f.write(page.body) }
      page
    end
  end

  def course_list_url
    "http://www.kurser.dtu.dk/search.aspx?lstDepartment=1,10,11,12,13,23,24,25,26,27,28,30,31,33,34,41,42,46,47,48,59,IHK,83&YearGroup=2014-2015"
  end

  def agent
    @agent ||= Mechanize.new
  end

  class Course
    attr_reader :course_number, :course_runs

    def initialize(course_number, course_runs)
      @course_number = course_number
      @course_runs   = course_runs
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
        Array(Schedule.new("Udenfor skema-struktur", nil))
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
      ["Udenfor skema-struktur"].include?(scraped_season)
    end

    private

    def map_schedule_season_from_danish
      {
        "Forår" => "spring",
        "Efterår" => "autumn",
        "F" => "spring",
        "E" => "autumn",
        "January" => "january",
        "June" => "june",
        "SummerSchool" => "summer",
        "Udenfor skema-struktur" => 'unknown'
      }.fetch(scraped_season)
    end
  end
end
