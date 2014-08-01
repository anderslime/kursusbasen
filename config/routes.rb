Rails.application.routes.draw do

  unless Rails.env.production?
    namespace :api do
      resources :students
      resources :course_autocompletes, only: [:index]
      resources :course_plannings, except: [:index, :new, :edit]
      resources :schedule_groups, only: [:index]
      resources :courses, only: [:index, :show]
      resources :special_courses, only: [:create, :show]
    end
    resources :students, only: [:show]
  end

  root :to => "courses#index"

  resources :courses, only: [:show]

end
