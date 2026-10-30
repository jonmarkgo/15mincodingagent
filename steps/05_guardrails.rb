# 05: guardrails. Every tool call passes these checks before step 4's run_tool runs it.
require_relative "04_act"

alias unguarded_run_tool run_tool   # keep step 4's version
SAFE = /\Aruby [\w.]+\.rb( [\w.-]+)*\z/   # a .rb file in the folder, plain args

def run_tool(name, args)
  path = args["path"].to_s
  if path.start_with?("/") || path.include?("..")
    return "error: #{path} is outside the workspace"
  end
  if name == "run_shell" && !args["command"].match?(SAFE)
    print "Approve `#{args["command"]}`? [y/N] "
    answer = $stdin.gets.to_s.strip.downcase
    return "error: a human said no. Don't retry it." unless answer == "y"
  end
  unguarded_run_tool(name, args)
end

if $PROGRAM_NAME == __FILE__
  reply = ask(start(ARGV.join(" ")), tools: TOOL_SPECS)
  reply["tool_calls"].to_a.each { |call| puts act(call) }
end
