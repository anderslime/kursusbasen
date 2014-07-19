Ember.CourseAutocompleteComponent = Ember.TextField.extend
  classNames: 'form-control',
  didInsertElement: ->
    remoteSource = new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: @get('remote')

    remoteSource.initialize();

    @typeahead = @.$().typeahead(
      {
        highlight: true,
        minLength: 1,
        hint: true
      },
      {
        name: 'typeahead',
        displayKey: 'title',
        source: remoteSource.ttAdapter(),
        templates:
          suggestion: Handlebars.compile("<strong>{{course_number}}</strong> - {{title}}")
      }
    )

    @typeahead.on 'typeahead:selected', (event, item) =>
      @set 'selection', item

    @typeahead.on 'typeahead:autocompleted', (event, item) =>
      @set 'selection', item

Ember.Handlebars.helper('type-ahead', Ember.CourseAutocompleteComponent)
