Kursusbasen.SpecialCourse = DS.Model.extend
  title: DS.attr 'string'
  ectsPoints: DS.attr 'number'
  courseNumber: "SpecialCourse"
  scheduleGroups: DS.hasMany 'scheduleGroup', async: true
