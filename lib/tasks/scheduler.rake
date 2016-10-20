desc "Clean Older Carts - This task is called by the Heroku scheduler add-on"
task :clean_older_carts => :environment do
  puts "Cleaning Older Carts..."
  Cart.delete_all
  puts "done."
end
