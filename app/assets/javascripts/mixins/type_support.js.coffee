Kursusbasen.TypeSupport = Ember.Mixin.create
  classTypePrefix: Ember.required(String)
  classNameBindings: ['typeClass']
  type: 'default'

  typeClass: ( ->
      type = Ember.get 'type'
      type = 'default' if not type?

      pref = Ember.get 'classTypePrefix'
      "#{pref}-#{type}"
  ).property('type')

