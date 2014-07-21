Kursusbasen.AddToStudyPlanComponent = Ember.Component.extend
  actions:
    setPlannedCourseSemester: (coursePlanning, semester) ->
      coursePlanning.set('season', semester.season)
      coursePlanning.set('year', semester.year)
      coursePlanning.save()
