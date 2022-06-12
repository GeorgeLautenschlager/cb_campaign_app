require 'listen'

namespace :file_watcher do
  desc "Watch for new mission files"
  task :watch, [:proto_path] => :environment do |t, args|
    puts "Listening for new campaign states"
    listener = Listen.to(args[:proto_path]) do |modified, added, removed|
      if new_state_file = added.find { |entry| entry.include? 'velikie-campaign.state' }
        puts 'New campaign state detected'
        deck_generator = MissionCards::DeckGenerator.new(MissionCards::DeckConfiguration.new(new_state_file))
        puts 'Generating mission cards'
        deck_generator.generate!
        puts 'Dealing new hands'
        Pilot.all.each(&:deal_hand!)
        puts "New Hands Dealt"
        puts 'Listening for file changes...'
      end
    end
    puts 'Listening for file changes...'
    listener.start
    sleep
    puts "Shutting down"
  end
end
