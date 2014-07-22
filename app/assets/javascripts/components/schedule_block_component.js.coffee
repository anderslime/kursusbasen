Kursusbasen.ScheduleBlockComponent = Ember.Component.extend
  classNameBindings: ['hasCourseScheduled']
  tagName: 'td'
  classNames: ['study-plan-schedule-block']
  scheduledCourses: Ember.computed.mapBy('plannedCourses', 'course')
  courseScheduled: (->
    @get('scheduledCourses').find (course) =>
      course.get('scheduleBlocks').any (block) => block is @get('block')
  ).property('scheduledCourses.@each.scheduleBlocks')
  hasCourseScheduled: Ember.computed.notEmpty('courseScheduled')
  courseTitle: Ember.computed.alias('courseScheduled.title')
  courseNumber: Ember.computed.alias('courseScheduled.courseNumber')
