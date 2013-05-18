(1..7).each do |i|
  url = "https://raw.github.com/goggin13/Homepage/master/blogs/#{i}.md"
  file = "#{i}.md"
  system(file)
  system("curl #{url} >> #{i}.md")
  system("cat #{file}")
end
