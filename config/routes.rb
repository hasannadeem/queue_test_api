# frozen_string_literal: true

Rails.application.routes.draw do
  resources :job_queue, only: [] do
    resources :background_jobs, only: %i[index create]
  end
end
