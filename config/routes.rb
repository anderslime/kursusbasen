Rails.application.routes.draw do

  namespace :api do
    resources :students
    resources :course_autocompletes, only: [:index]
    resources :course_plannings, except: [:index, :new, :edit]
    resources :schedule_groups, only: [:index]
    resources :courses, only: [:index, :show]
    resources :special_courses, only: [:create, :show]
  end

  root :to => "courses#index"

  resources :courses, only: [:show]

  resources :students, only: [:show]
end
