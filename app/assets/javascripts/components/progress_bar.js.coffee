Kursusbasen.ProgressBarComponent = Ember.Component.extend(Kursusbasen.TypeSupport,
  classNames: ['progress-bar']
  attributeBindings: ['style', 'role', 'aria-valuemin', 'ariaValueNow:aria-valuenow', 'aria-valuemax']
  classTypePrefix: 'progress-bar'
  role: 'progressbar'
  'aria-valuemin': 0
  'aria-valuemax': 100

  style: (->
    "width:#{@progress}%;"
  ).property('progress')

  ariaValueNow: (->
    @get('progress')
  ).property('progress')
)
Ember.Handlebars.helper 'kb-progressbar', Kursusbasen.ProgressBarComponent
