require 'fileutils'

namespace :db do
  desc "read blogs from blogs directory"
  
  task read_blogs: :environment do
    user = User.create! username: 'goggin13', password: 'password'
    unless user
      puts "counldnt find goggin13"
      puts 5/0 
    end

    Dir.glob("blogs/*.md").each do |path|
      lines = File.readlines(path).to_a
      title = lines[0].sub("# ", "")
      post = user.posts.build title: title, content: lines[2..lines.length].join("\n")
      if post.save
        puts "saved #{post.title}"
      else
        post.errors.full_messages.each { |err| puts err }
      end
    end
  end
end

