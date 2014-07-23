Kursusbasen.AddToStudyPlanComponent = Ember.Component.extend
  actions:
    setPlannedCourseSemester: (coursePlanning, semester) ->
      coursePlanning.scheduleFor(semester.season, semester.year)
