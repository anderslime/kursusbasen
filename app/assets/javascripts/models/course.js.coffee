Kursusbasen.Course = DS.Model.extend
  title: DS.attr 'string'
  ectsPoints: DS.attr 'number'
  courseNumber: DS.attr 'string'
  student: DS.belongsTo 'student'
  scheduleBlocks: DS.attr 'raw'
