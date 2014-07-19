Kursusbasen.IndexController = Ember.Controller.extend
  selectedCourse: null,
  addCourseToBasket: (->

    console.log @get('selectedCourse')
    @set('selectedCourse', null)
  ).observes('selectedCourse')
  autocompleteRemote: 'http://kursusbasen.dev/api/course_autocompletes.json?query=%QUERY'
