require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test" # needed to require test/helper.rb
  t.test_files = FileList["test/**/test_*.rb"]
end
