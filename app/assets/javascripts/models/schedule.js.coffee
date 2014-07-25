Kursusbasen.Schedule = DS.Model.extend
  block: DS.attr 'string'
  season: DS.attr 'string'

  isOffNormalSchedule: (->
    Kursusbasen.Semester.isOffNormalSchedule(@get('season'))
  ).property('season')

