# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resource :trips, only: %w(create)

      get "stats/weekly", to: "trips#weekly_stats"
    end
  end
end
