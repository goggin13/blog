namespace :db do
  desc "db related tasks"
  
  def spaces
    [User, Post]
  end
  
  task recreate_spaces: :environment do
    spaces.each do |klass|
      puts "recreating #{klass.space_name}"
      klass.destroy_space
      klass.create_space
    end
  end
  
  task destroy_spaces: :environment do
    spaces.each do |klass|
      puts "destroying #{klass.space_name}"
      klass.destroy_space
    end
  end

  task create_spaces: :environment do
    spaces.each do |klass|
      puts "creating #{klass.space_name}"
      klass.create_space
    end
  end
end
