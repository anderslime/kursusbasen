Kursusbasen.CoursePlanning = DS.Model.extend
  student: DS.belongsTo 'student', async: true
  course: DS.belongsTo 'course', async: true
  scheduleGroup: DS.belongsTo 'scheduleGroup', async: true
  year: DS.attr 'string'

  isScheduled: (->
    !Ember.isEmpty(@get('year')) && !Ember.isEmpty(@get('scheduleGroup'))
  ).property('year', 'scheduleGroup')

  isScheduledFor: (block, season) ->
    @get('scheduleGroup.schedules').any (schedule) ->
      schedule.get('block') is block && schedule.get('season') is season

  scheduleFor: (scheduleGroup, year) ->
    @set('scheduleGroup', scheduleGroup)
    @set('year', year)
    @save()

  unschedule: ->
    @scheduleFor(null, null)
