require 'fileutils'

namespace :db do
  desc "read blogs from blogs directory"
  
  task read_blogs: :environment do
    user = User.where(username: 'goggin13')[0]
    unless user
      user = User.create! username: 'goggin13', password: 'password'
    end

    user.posts.each { |p| p.destroy }

    (1..7).each do |i|
      url = "https://raw.github.com/goggin13/Homepage/master/blogs/#{i}.md"
      file = "#{i}.md"
      system("curl #{url} >> #{i}.md")
      lines = File.readlines(file).to_a
      system("rm #{file}")
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

