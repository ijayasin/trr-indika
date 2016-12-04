namespace :txt do
  task :mkdir do
    require 'fileutils'
    FileUtils.mkdir_p 'doc'
  end

  desc "Generates text files for Rake tasks."
  task rake: [:environment, :mkdir] do
    puts "Creating doc/routes.txt"
    `bin/rails routes | tee doc/routes.txt`
  end

  desc "Generates text files for routes."
  task routes: [:environment, :mkdir] do
    puts "Creating doc/rake.txt"
    `bin/rake -T | tee doc/rake.txt`
  end

  task gone: [:environment, :mkdir] do
    puts "Creating doc/rails-generate.txt."
    str = `rails g --help | tee doc/rails-generate.txt`
  end

  desc "Generates text files for generators."
  task g: [:environment, :mkdir] do
    puts "Creating text files for generators."
    str = `rails g --help | tee doc/rails-generate.txt`
    arr = str.split(/^Rails:$/).last.split("\n").select{|v| v =~ /^  / && !v.strip.empty? }.map{|v| v.strip}
    arr.each do |t|
      ts = t.gsub(':', '-')
      fn = "doc/rails-generate-#{ts}.txt"
      puts "Creating #{fn}"
      `bin/rails g #{t} --help | tee #{fn}`
    end
    puts "Done creating text files for generators."
  end


  desc "Generates text files for Rake tasks and routes."
  task rr: [:environment, :mkdir, :rake, :routes] do
  end

  desc "Generates text files for Rake tasks, routes, and generators."
  task all: [:environment, :mkdir, :rake, :routes, :g] do
  end

end
