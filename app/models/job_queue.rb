# frozen_string_literal: true

class JobQueue < ApplicationRecord
  has_many :background_jobs
end
