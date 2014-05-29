if Rails.env.production?
  ENV['ELASTICSEARCH_URL'] = ENV['SEARCHBOX_URL']
end
