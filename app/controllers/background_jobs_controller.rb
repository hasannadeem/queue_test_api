# frozen_string_literal: true

# class BackgroundJobsController
class BackgroundJobsController < ApplicationController
  before_action :set_job_queue, only: %i[index create]

  def index
    @background_jobs = @job_queue.background_jobs

    render json: @background_jobs
  end

  def create
    @background_job = @job_queue.background_jobs.create(background_job_params)

    render json: @background_job
  end

  private

  def background_job_params
    params.require(:background_job).permit(
      :name,
      :starts_at,
      :expires_at,
      :status,
      :priority
    )
  end

  def set_job_queue
    @job_queue = JobQueue.find(params[:job_queue_id])
  end
end
