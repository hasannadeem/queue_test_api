# frozen_string_literal: true

class JobQueue < ApplicationRecord
  has_many :background_jobs

  def process
    background_jobs.each do |job|
      call(job.name(job))
    end
  end

  def display_current_datetime(job)
    job.done! if puts DateTime.now
  end
end