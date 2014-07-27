Kursusbasen.SpecialCourse = DS.Model.extend
  student: DS.belongsTo 'student'
  title: DS.attr 'string'
  ectsPoints: DS.attr 'number'
