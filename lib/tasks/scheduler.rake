desc "This task will find jobs to be reviewed every 10 minutos"
task :review_jobs => :environment do
  puts "Checking Jobs..."
  Job.should_be_reviewed
  puts "done."
end
