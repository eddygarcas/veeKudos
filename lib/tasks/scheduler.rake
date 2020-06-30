desc "This task is called by the Heroku scheduler add-on"
task :send_leader_list => :environment do
  puts "Leader list..."
  KudosJob.perform_now
  puts "done."
end