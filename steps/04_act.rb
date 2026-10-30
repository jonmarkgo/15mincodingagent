# 04: the model asks, Ruby acts. Turn step 3's tool call into a call to one of step 2's methods.
require_relative "03_describe"

TOOLS = %w[list_files read_file write_file run_shell]   # step 2

def act(call)                                    # one tool call from step 3
  name = call["function"]["name"]
  args = JSON.parse(call["function"]["arguments"])   # a JSON string
  puts "→ #{name} #{args.except("content").to_json}"
  run_tool(name, args)
rescue => e
  "error: #{e.message}"   # mistakes become feedback, not crashes
end

def run_tool(name, args)
  raise "unknown tool: #{name}" unless TOOLS.include?(name)
  send(name, args)        # call the step 2 method with that name
end

if $PROGRAM_NAME == __FILE__
  reply = ask(start(ARGV.join(" ")), tools: TOOL_SPECS)
  reply["tool_calls"].to_a.each { |call| puts act(call) }
end
