# frozen_string_literal: true

default_queue = JobQueue.find_or_create_by!(name: 'default')
default_job = default_queue.background_jobs.find_by(name: 'default_background_job') || default_queue.background_jobs.create!(
  name: 'default_background_job',
  priority: :high,
  status: :waiting,
  starts_at: DateTime.now + 1.day,
  expires_at: DateTime.now + 2.days
)

100.times do
  job_name = %w[display_current_datetime save_movie_title].sample
  default_queue.background_jobs.create!(
    name: job_name,
    job_param: job_name == 'save_movie_title' ? 'movie1 movie2 movie3 movie4 movie5' : nil,
    priority: :high,
    status: :waiting,
    starts_at: DateTime.now,
    expires_at: DateTime.now + 2.days
  )
end
