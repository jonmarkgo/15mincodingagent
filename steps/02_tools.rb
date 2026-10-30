# 02: tools are plain Ruby methods. The model can't touch your computer. Only these can.
require "open3"
require "json"
require "fileutils"

WORKSPACE = "workspace"   # every tool works inside this one folder

def list_files(args)
  Dir.children(WORKSPACE).sort.join("\n")
end

def read_file(args)
  File.read(File.join(WORKSPACE, args["path"]))
end

def write_file(args)
  File.write(File.join(WORKSPACE, args["path"]), args["content"])
  "wrote #{args["path"]}"
end

# Open3.capture2e runs a command and captures everything it prints
def run_shell(args)
  output, _status = Open3.capture2e(args["command"], chdir: WORKSPACE)
  output
end

# Start the demo folder fresh: one script with a bug, and one skill.
def reset_workspace
  FileUtils.rm_rf(WORKSPACE)
  FileUtils.mkdir_p("#{WORKSPACE}/skills/readme")
  File.write("#{WORKSPACE}/greet.rb", <<~'CODE')
    names = ["Ada", "Grace", "Linus"]
    names.each { |name| puts "Hello, #{nme}!" }
  CODE
  File.write("#{WORKSPACE}/skills/readme/SKILL.md", <<~SKILL)
    ---
    name: readme
    description: How to write the README for a small Ruby script
    ---
    Write README.md with exactly these three sections:
    ## What it does   (one sentence)
    ## How to run it  (the exact command)
    ## Example output (what it prints)
    End with this line: Built offline at Hacktoberfest Brooklyn!
  SKILL
end
