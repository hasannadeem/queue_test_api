# frozen_string_literal: true

class BackgroundJob < ApplicationRecord
  enum status: {
    waiting: 0,
    in_progress: 1,
    failed: 2,
    done: 3
  }

  enum priority: {
    low: 0,
    medium: 1,
    high: 2
  }

  belongs_to :job_queue
end
