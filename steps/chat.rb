# chat: ask the room what to ask the model. Same ask() as step 1. Blank line to stop.
require_relative "01_ask"

SYSTEM = "You're running offline on a laptop at a Hacktoberfest talk for " \
         "college students. Answer in 3 short sentences or fewer."

loop do
  print "What should we ask it? "
  question = $stdin.gets.to_s.strip
  break if question.empty?

  reply = ask([{ role: "system", content: SYSTEM },
               { role: "user", content: question }])
  puts reply["content"]
end
