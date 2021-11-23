# frozen_string_literal: true

default_queue = JobQueue.find_or_create_by!(name: 'default')
default_job = default_queue.background_jobs.find_by(name: 'default_background_job') || default_queue.background_jobs.create!(
  name: 'default_background_job',
  priority: :high,
  status: :waiting,
  starts_at: DateTime.now + 1.day,
  expires_at: DateTime.now + 2.days
)
