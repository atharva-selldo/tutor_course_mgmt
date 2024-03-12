Rails.application.routes.draw do
  resources :courses, only: %w[create index]
  resources :tutors, only: :create
end
