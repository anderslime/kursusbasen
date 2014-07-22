Kursusbasen.Schedule = DS.Model.extend
  block: DS.attr 'string'
  season: DS.attr 'string'
  course: DS.belongsTo 'course'
