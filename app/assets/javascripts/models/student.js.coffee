Kursusbasen.Student = DS.Model.extend
  studentNumber: DS.attr 'string'
  coursePlannings: DS.hasMany 'course_planning', async: true
