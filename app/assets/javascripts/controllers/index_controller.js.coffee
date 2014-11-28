Kursusbasen.IndexController = Ember.Controller.extend
  coursePlannings: Ember.computed.alias('model.coursePlannings')
  unscheduledCoursePlannings: Ember.computed.filterBy('coursePlannings', 'isScheduled', false)
  scheduledCoursePlannings: Ember.computed.filterBy('coursePlannings', 'isScheduled', true)
  studentNumber: Ember.computed.alias('model.studentNumber')
  scheduledCourses: Ember.computed.mapBy('scheduledCoursePlannings', 'course')
  ectsPointsPlanned: (->
    @get('scheduledCourses').reduce((previousValue, course) ->
      previousValue + course.get('ectsPoints')
    , 0)
  ).property('scheduledCourses.@each.ectsPoints')
  ectsPointsNeeded: 120
  progress: (->
    @get('ectsPointsPlanned') / @get('ectsPointsNeeded') * 100.0
  ).property('ectsPointsPlanned')
  studyPlannerCategories: Kursusbasen.MASTER_CATEGORIES

  upcomingSemesters: (->
    [
      { season: 'autumn', hasSummerCourse: false, year: '2014/2015' },
      { season: 'spring', hasSummerCourse: false, year: '2015/2016' },
      { season: 'autumn', hasSummerCourse: false, year: '2015/2016' },
      { season: 'spring', hasSummerCourse: false, year: '2016/2017' },
      { season: 'autumn', hasSummerCourse: false, year: '2016/2017' }

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
