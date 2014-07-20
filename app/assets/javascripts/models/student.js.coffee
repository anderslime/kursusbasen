Kursusbasen.Student = DS.Model.extend
  studentNumber: DS.attr 'string'
  plannedCourses: DS.hasMany 'course', async: true
