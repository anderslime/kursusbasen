namespace_error = (progress, level, path) ->
  "Namespace error! Augmentation not allowed for non-objects. '#{progress.join('.')}' is a type of #{typeof level}. Namespace '#{path}' could not be defined."
split_path = (path) ->
  path.split('.')
augmentable = (object) ->
  object.constructor is Object

window.namespace = (path, root = window) ->

  levels = split_path(path)
  progress = []

  parent_level = root

  for current_level in levels
    progress.push current_level
    current_object = parent_level[current_level]
    if current_object?
      unless augmentable(current_object)
        throw namespace_error(progress, current_object, path)
    else
      parent_level[current_level] = {}
    parent_level = parent_level[current_level]

  return parent_level
