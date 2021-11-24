namespace :job do
  desc 'invoke job by id through command line'
  task :run, [:job_id], :environment do |task, args|
    puts '*******************************'
    puts '-------------------------------'
    puts 'Running custom job'
    puts '-------------------------------'
    puts '*******************************'
    sleep 10

    JobQueue.all.each do |queue|
      JobQueueJob.perform_now(1)
    end
  end
end
