# 01: inference is an HTTP call. Like submitting a form and doing something with the result.
require "net/http"
require "json"

BASE  = ENV.fetch("LLM_URL", "http://localhost:11434/v1")
MODEL = ENV.fetch("LLM_MODEL", "gemma4:12b-mlx")

def ask(messages, tools: nil)
  body = { model: MODEL, messages: messages, tools: tools,
           temperature: 0.2, reasoning_effort: "none" }.compact
  uri  = URI("#{BASE}/chat/completions")
  res  = Net::HTTP.start(uri.host, uri.port, read_timeout: 300) do |http|
    http.post(uri.path, body.to_json,
              "Content-Type" => "application/json")
  end
  JSON.parse(res.body)["choices"][0]["message"]
end

if $PROGRAM_NAME == __FILE__
  puts ask([{ role: "user", content: ARGV.join(" ") }])["content"]
end
