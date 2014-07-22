Kursusbasen.IndexController = Ember.Controller.extend
  coursePlannings: Ember.computed.alias('model.coursePlannings')
  unscheduledCoursePlannings: (->
    @get('coursePlannings').filterBy('isScheduled', false)
  ).property('coursePlannings.@each.isScheduled')
  studentNumber: Ember.computed.alias('model.studentNumber')
  upcomingSemesters: (->
    [
      { season: 'autumn', year: 2014 }
      { season: 'spring', year: 2014 },
      { season: 'autumn', year: 2015 },
      { season: 'spring', year: 2015 }
    ].map (semester_data) =>
      Kursusbasen.SemesterSchedule.create(
        season: semester_data.season,
        year: semester_data.year,
        controller: @
      )
  ).property()
