Kursusbasen.ScheduleGroup = DS.Model.extend
  schedules: DS.hasMany 'schedule'
  scheduleSeasons: Ember.computed.mapBy('schedules', 'season')
