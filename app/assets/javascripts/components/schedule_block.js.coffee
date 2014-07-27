Kursusbasen.ScheduleBlockComponent = Ember.Component.extend
  coursePlanningsForScheduleYear: []

  scheduledCourses: Ember.computed.mapBy('coursePlannings', 'course')
  scheduledCoursePlanning: (->
    @get('coursePlanningsForScheduleYear').find (coursePlanning) =>
      coursePlanning.isScheduledFor(@get('season'), @get('block'))
  ).property('coursePlanningsForScheduleYear.@each', 'block', 'season')
  scheduledCourse: Ember.computed.alias('scheduledCoursePlanning.course')
  hasCourseScheduled: Ember.computed.notEmpty('scheduledCourse')
  courseTitle: Ember.computed.alias('scheduledCourse.title')
  courseNumber: Ember.computed.alias('scheduledCourse.courseNumber')
  scheduledCoursePlanningCategory: Ember.computed.alias('scheduledCoursePlanning.category')
  dashedCoursePlanningCategory: (->
    return null if Ember.isEmpty(@get('scheduledCoursePlanningCategory'))
    @get('scheduledCoursePlanningCategory').replace('_', '-')
  ).property('scheduledCoursePlanningCategory')

  classNameBindings: ['hasCourseScheduled', 'dashedCoursePlanningCategory']

  actions:
    unscheduleCourse: ->
      @get('scheduledCoursePlanning').unschedule()
