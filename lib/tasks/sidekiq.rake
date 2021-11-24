namespace :sidekiq do
  desc 'Sidekiq like server'
  task server: :environment do
    puts '*******************************'
    puts '-------------------------------'
    puts 'Sidekiq Server has been started'
    puts '-------------------------------'
    puts '*******************************'
    loop do
      sleep(1) unless ActiveRecord::Base.connected?

      JobQueue.all.each do |queue|
        next until queue.background_jobs.waiting.count.positive?

        JobQueueJob.perform_now(queue.id)
      end
    end
  end
end
