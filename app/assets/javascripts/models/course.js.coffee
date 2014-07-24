Kursusbasen.Course = DS.Model.extend
  title: DS.attr 'string'
  ectsPoints: DS.attr 'number'
  courseNumber: DS.attr 'string'
  student: DS.belongsTo 'student'
  scheduleGroups: DS.hasMany 'scheduleGroup', async: true
