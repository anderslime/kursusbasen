Kursusbasen.IndexController = Ember.Controller.extend
  coursePlannings: Ember.computed.alias('model.coursePlannings')
  unscheduledCoursePlannings: (->
    @get('coursePlannings').filterBy('isScheduled', false)
  ).property('coursePlannings.@each.isScheduled')
  studentNumber: Ember.computed.alias('model.studentNumber')
  upcomingSemesters:
    [
      { title: 'Forår 2013', season: 'spring', year: 2013 },
      { title: 'Efterår 2013', season: 'autumn', year: 2013 }
    ]
