# frozen_string_literal: true

# class JobQueueJob
class JobQueueJob < ApplicationJob
  def perform(queue_id)
    queue = JobQueue.find(queue_id)
    queue.background_jobs.waiting.each do |job|
      next if job.starts_at >= DateTime.now

      job.in_progress!
      self.class.instance_methods.include?(job.name.to_sym) ? send(job.name, job) : display_name_error(job)
    end
  end

  def display_name_error(job)
    puts 'Job Name Error'
    job.failed!
  end

  def display_current_datetime(job)
    sleep(100)
    puts DateTime.now
    job.done!
  end

  def save_movie_title(job)
    job.job_param.split.each do |movie_title|
      puts "#{movie_title} has been saved to database\n" if Movie.create(title: movie_title)
    end
    job.done!
  end

  def external_call(job_id)
    job = BackgroundJob.find(job_id)
    return if !job.waiting? || job.starts_at >= DateTime.now

    job.in_progress!
    self.class.instance_methods.include?(job.name.to_sym) ? send(job.name, job) : display_name_error(job)
  end

  class << self
    def external_call(job_id)
      job = BackgroundJob.find(job_id)
      return if !job.waiting? || job.starts_at >= DateTime.now

      job.in_progress!
      instance_methods.include?(job.name.to_sym) ? send(job.name, job) : display_name_error(job)
    end

    def display_name_error(job)
      puts 'Job Name Error'
      job.failed!
    end

    def display_current_datetime(job)
      sleep(10)
      puts DateTime.now
      job.done!
    end

    def save_movie_title(job)
      job.job_param.split.each do |movie_title|
        puts "#{movie_title} has been saved to database\n" if Movie.create(title: movie_title)
      end
      job.done!
    end
  end
end
