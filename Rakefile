require "bundler/gem_tasks"

require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |task|
  task.name = :test
  task.test_files = FileList['test/test*.rb']
end

task :cache, [:account_id, :api_key] do |task, args|
  unless args.api_key && args.account_id
    puts('cache requires an account id and api key, please call as `cache[account_id api_key]`')
  else
    require "#{File.dirname(__FILE__)}/lib/xplenty/api"
    xplenty = Xplenty::API.new(:api_key => args.api_key, :account_id => args.account_id)

    clusters = Xplenty::API::OkJson.encode(xplenty.clusters.body)
    File.open("#{File.dirname(__FILE__)}/lib/xplenty/api/mock/cache/clusters.json", 'w') do |file|
      file.write(clusters)
    end

    jobs = Xplenty::API::OkJson.encode(xplenty.jobs.body)
    File.open("#{File.dirname(__FILE__)}/lib/xplenty/api/mock/cache/jobs.json", 'w') do |file|
      file.write(jobs)
    end
  end
end
