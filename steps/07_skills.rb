# 07: skills. Instructions in a file. The agent reads one with step 2's read_file when it helps.
require_relative "06_loop"

def skill_menu                          # name + description only, not the whole file
  Dir["#{WORKSPACE}/skills/*/SKILL.md"].map do |path|
    about = File.read(path)[/^description: (.*)$/, 1]
    "- #{path.delete_prefix("#{WORKSPACE}/")}: #{about}"
  end.join("\n")
end

def start(task)                         # step 3's start, plus the skill menu
  menu = "\nSkills (read one with read_file when it helps):\n#{skill_menu}"
  [{ role: "system", content: SYSTEM + menu }, { role: "user", content: task }]
end

if $PROGRAM_NAME == __FILE__
  reset_workspace
  agent("Fix greet.rb. Then add a README.")
  readme = "#{WORKSPACE}/README.md"
  puts "\n" + File.read(readme).lines.last(3).join if File.exist?(readme)
end
