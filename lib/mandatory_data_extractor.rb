class MandatoryDataExtractor
  attr_reader :page

  def initialize(page)
    @page = page
  end

  def teaching_form
    extract(:teaching_form)
  end

  def duration
    extract(:duration)
  end

  def former_course
    extract(:former_course)
  end

  def participant_limit
    extract(:participant_limit)
  end

  def registration
    extract(:registration)
  end

  def exam_form
    extract(:exam_form)
  end

  def exam_duration
    extract(:exam_duration)
  end

  def exam_aid
    extract(:exam_aid)
  end

  def evaluation_form
    extract(:evaluation_form)
  end

  def ects_points
    extract(:ects_points).gsub(",", ".").to_f
  end

  private

  def extract(title_key)
    ColumnContentExtractor.new(page).content(row_titles[title_key])
  end

  def row_titles
    {
      :teaching_form => "Undervisningsform:",
      :duration => "Kursets varighed:",
      :former_course => "Tidligere kursus:",
      :participant_limit => "Deltagerbegrænsning:",
      :registration => "Tilmelding:",
      :exam_form => "Evalueringsform:",
      :exam_duration => "Eksamens varighed:",
      :exam_aid => "Hjælpemidler:",
      :evaluation_form => "Bedømmelsesform:",
      :qualified_prereq => "Faglige forudsætninger:",
      :ects_points => "Point (ECTS )",
      :language => "Sprog:"
    }
  end
end
