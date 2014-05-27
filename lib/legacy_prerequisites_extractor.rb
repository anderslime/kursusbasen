class LegacyPrerequisitesExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def point_block
    extract(:point_block)
  end

  def mandatory_prerequisites
    extract(:mandatory_prerequisites)
  end

  def optional_prerequisites
    extract(:optional_prerequisites)
  end

  def qualified_prerequisites
    extract(:qualified_prerequisites)
  end

  private

  def extract(title_key)
    has_letters = false
    column = content_for_attribute(title_key)
    return nil if column.blank?

    #find_letters = %r{([a-zA-Z])}.match(column)
    has_letters = true if !%r{([a-zA-Z])}.match(column).nil?
    and_split_courses = [] # Array to hold each course-group seperated by .

    # Splits the column by .
    and_split = column.split('.')
    and_split.each do |req_and|

      # Splits each part seperated by /
      or_split = req_and.split('/')
      or_split_courses = [] # Array to hold each course-group seperated by /
      or_split.each do |req_or|
        # A regex to match digits of length 5 (course number!)
        course_digits = %r{(\d{5}).*}.match(req_or.chomp.strip)
        or_split_courses << course_digits[1].to_s.chomp.strip if !course_digits.nil?
      end
      and_split_courses << or_split_courses if !or_split_courses.empty?
    end
    # Adding to the database
    # Extract as data:
    # current_course_prereq[key] = and_split_courses if !and_split_courses.empty?
    if has_letters
      column
    else
      and_split_courses.map {|and_split|
        and_split.join('/')
      }.join(".")
    end
  end

  def content_for_attribute(title_key)
    ColumnContentExtractor.new(page).content(attribute_titles[title_key])
  end

  def attribute_titles
    {
      :point_block => "Pointspærring:",
      :mandatory_prerequisites => "Obligatoriske forudsætninger:",
      :qualified_prerequisites => "Faglige forudsætninger:",
      :optional_prerequisites => "Ønskelige forudsætninger:"
    }
  end
end
