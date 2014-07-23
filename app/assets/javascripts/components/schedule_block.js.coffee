Kursusbasen.ScheduleBlockComponent = Ember.Component.extend
  classNameBindings: ['hasCourseScheduled']
  tagName: 'td'
  classNames: ['study-plan-schedule-block']
  scheduledCourses: Ember.computed.mapBy('coursePlannings', 'course')
  courseScheduled: (->
    @get('scheduledCourses').find (course) =>
      course.get('scheduleBlocks').any (block) => block is @get('block')
  ).property('scheduledCourses.@each.scheduleBlocks')
  scheduledCoursePlanning: (->
    @get('coursePlannings').find (planning) =>
      planning.get('course.id') is @get('courseScheduled.id')
  ).property('scheduledCourses.@each.id', 'courseScheduled.id')
  hasCourseScheduled: Ember.computed.notEmpty('courseScheduled')
  courseTitle: Ember.computed.alias('courseScheduled.title')
  courseNumber: Ember.computed.alias('courseScheduled.courseNumber')
  actions:
    unscheduleCourse: ->
      @get('scheduledCoursePlanning').unschedule()
