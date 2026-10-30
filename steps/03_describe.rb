# 03: describe the tools to the model, then ask with them. It can't run anything. It can only ask.
require_relative "01_ask"
require_relative "02_tools"

# A tool description is just data: a name, what it does, what it needs.
def describe(name, what, *params)
  props = params.to_h { |param| [param, { type: "string" }] }
  { type: "function",
    function: { name: name, description: what,
                parameters: { type: "object", properties: props,
                              required: params } } }
end

TOOL_SPECS = [                                 # step 2's methods
  describe("list_files", "List the files in the folder"),
  describe("read_file",  "Read a file", "path"),
  describe("write_file", "Create or replace a file", "path", "content"),
  describe("run_shell",  "Run a command; output and errors come back", "command")
]

SYSTEM = <<~PROMPT
  You are a coding agent working in a folder. Use the tools; don't guess.
  See files with list_files. Run a script with: ruby NAME.rb (one
  command at a time, no &&).
  Write plain Ruby, no gems. Run your code to check it works. If it
  fails, read the error and fix it. When you're done, answer briefly.
PROMPT

def start(task)                                  # the job, then the task
  files = list_files({}).split.join(", ")        # step 2: what's here now
  [{ role: "system", content: "#{SYSTEM}Files in the folder: #{files}" },
   { role: "user", content: task }]
end

if $PROGRAM_NAME == __FILE__
  reply = ask(start(ARGV.join(" ")), tools: TOOL_SPECS)   # step 1 + tools
  call  = reply["tool_calls"].first
  puts "It asks for: #{call["function"].to_json}"
  puts "(Nothing ran. It can only ask.)"
end
