Kursusbasen.CoursePlanning = DS.Model.extend
  student: DS.belongsTo 'student', async: true
  course: DS.belongsTo 'course', async: true
  year: DS.attr 'number'
  season: DS.attr 'string'

  isScheduled: (->
    !Ember.isEmpty(@get('year')) && !Ember.isEmpty(@get('season'))
  ).property('year', 'season')

  scheduleFor: (season, year) ->
    @set('season', season)
    @set('year', year)
    @save()

  unschedule: ->
    @scheduleFor(null, null)
