Kursusbasen.IndexController = Ember.Controller.extend
  coursePlannings: Ember.computed.alias('model.coursePlannings')
  unscheduledCoursePlannings: Ember.computed.filterBy('coursePlannings', 'isScheduled', false)
  scheduledCoursePlannings: Ember.computed.filterBy('coursePlannings', 'isScheduled', true)
  studentNumber: Ember.computed.alias('model.studentNumber')
  scheduledCourses: Ember.computed.mapBy('scheduledCoursePlannings', 'course')
  ectsPointsTotal: (->
    @get('scheduledCourses').reduce((previousValue, course) ->
      previousValue + course.get('ectsPoints')
    , 0)
  ).property('scheduledCourses.@each.ectsPoints')
  ectsPointsInSemester: 120
  progress: (->
    @get('ectsPointsTotal') / @get('ectsPointsInSemester') * 100.0
  ).property('ectsPointsTotal')
  upcomingSemesters: (->
    [
      { season: 'autumn', year: '2014/2015' }
      { season: 'spring', year: '2014/2015' },
      { season: 'autumn', year: '2015/2016' },
      { season: 'spring', year: '2015/2016' }
    ].map (semester_data) =>
      Kursusbasen.SemesterSchedule.create(
        season: semester_data.season,
        year: semester_data.year,
        controller: @
      )
  ).property()

  actions:
    unscheduleCourse: (coursePlanning) ->
      coursePlanning.unschedule()
