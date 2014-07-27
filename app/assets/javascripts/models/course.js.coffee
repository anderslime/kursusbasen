Kursusbasen.Course = DS.Model.extend
  title: DS.attr 'string'
  ectsPoints: DS.attr 'number'
  courseNumber: DS.attr 'string'
  scheduleGroups: DS.hasMany 'scheduleGroup', async: true
