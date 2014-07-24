Kursusbasen.ScheduleBlockComponent = Ember.Component.extend
  coursePlanningsForScheduleYear: []

  scheduledCourses: Ember.computed.mapBy('coursePlannings', 'course')
  scheduledCoursePlanning: (->
    console.log @get('coursePlanningsForScheduleYear')
    @get('coursePlanningsForScheduleYear').find (coursePlanning) =>
      coursePlanning.isScheduledFor(@get('block'), @get('season'))
  ).property('coursePlanningsForScheduleYear.@each', 'block', 'season')
  scheduledCourse: Ember.computed.alias('scheduledCoursePlanning.course')
  hasCourseScheduled: Ember.computed.notEmpty('scheduledCourse')
  courseTitle: Ember.computed.alias('scheduledCourse.title')
  courseNumber: Ember.computed.alias('scheduledCourse.courseNumber')

  classNameBindings: ['hasCourseScheduled']
  tagName: 'td'
  classNames: ['study-plan-schedule-block']

  actions:
    unscheduleCourse: ->
      @get('scheduledCoursePlanning').unschedule()
