# build: talk to the agent. Each request runs step 6's loop; the folder carries over between them.
require_relative "06_loop"

FileUtils.rm_rf(WORKSPACE)        # start from an empty folder
FileUtils.mkdir_p(WORKSPACE)

loop do
  print "\nWhat should it build or change? (blank line to stop) "
  request = $stdin.gets.to_s.strip
  break if request.empty?

  agent("#{request}. Work in app.rb and run it to check it works.")
end
