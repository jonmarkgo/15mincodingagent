# 06: the loop. Send each result back and ask again, until the model stops asking for tools.
require_relative "05_guardrails"

def agent(task, steps: 15)
  messages = start(task)                         # step 3
  steps.times do
    reply = ask(messages, tools: TOOL_SPECS)     # step 1 + step 3
    messages << reply
    calls = reply["tool_calls"].to_a
    return puts("✓ #{reply["content"]}") if calls.empty?   # done

    calls.each do |call|
      result = act(call).to_s                    # step 4
      puts result.lines.last(3).join
      messages << { role: "tool", tool_call_id: call["id"],
                    content: result[0, 3000] }   # the result goes back in
    end
  end
  puts "Stopped: out of steps"
end

if $PROGRAM_NAME == __FILE__
  reset_workspace   # fresh folder: greet.rb has a bug
  agent(ARGV.join(" "))
end
