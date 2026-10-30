# Build a simple coding agent, offline

From the talk "Building a Local Coding Agent in 15 Minutes" at Hacktoberfest Hack Day Brooklyn, October 30, 2026.

A coding agent in about 200 lines of plain Ruby: no gems, no internet, no API key. The model
picks tools (list, read, write, run a shell command), Ruby runs them, and the results go
back until the job is done. Each step is one small file that adds one idea.

## Run it on your laptop (Ollama + Gemma 4)

You need Ruby 3.1+ and [Ollama](https://ollama.com).

    ollama pull gemma4:e4b           # a laptop-sized Gemma 4; any chat model works
    export LLM_URL=http://localhost:11434/v1
    export LLM_MODEL=gemma4:e4b

    ruby steps/01_ask.rb "What is Hacktoberfest?"
    ruby steps/06_loop.rb "Run greet.rb and fix it if it's broken."

Smaller models make more mistakes, which is fine: watching the loop recover is the point.
Ideas that work well for `ruby steps/build.rb`: a quiz score grader, a BMI calculator, a rock paper scissors judge.

## The steps

| Step | File | The idea |
| --- | --- | --- |
| 1 | `steps/01_ask.rb` | Inference is an HTTP call: send a request, do something with the result |
| 2 | `steps/02_tools.rb` | Tools are plain Ruby methods: list, read, write, run a command |
| 3 | `steps/03_describe.rb` | Describe the tools, then ask with them; the model can only ask |
| 4 | `steps/04_act.rb` | The model asks, Ruby acts: turn a tool call into a method call |
| 5 | `steps/05_guardrails.rb` | Guardrails: stay in the folder; running a .rb file is fine, anything else asks |
| 6 | `steps/06_loop.rb` | The loop: send results back until it stops asking for tools |

Extras: `steps/hallucinate.rb` (ask with no tools, then check the truth), `steps/chat.rb` (a
chatbot), `steps/build.rb` (everything together: builds the idea you type), `steps/07_skills.rb`
(skills: instruction files the agent reads with `read_file` when relevant).

Each step requires the one before it. Try them in order:

    ruby -r ./steps/02_tools.rb -e reset_workspace     # demo folder: greet.rb (has a bug) + one skill
    ruby steps/hallucinate.rb                          # it claims what greet.rb prints; it never ran it
    ruby -r ./steps/02_tools.rb -e 'puts read_file("path" => "greet.rb")'   # a tool, by hand
    ruby steps/04_act.rb "Read greet.rb"               # one turn
    ruby steps/06_loop.rb "Run greet.rb and fix it if it's broken."
    ruby steps/07_skills.rb                            # fix it, then write a README per the skill
    ruby steps/build.rb                                # asks for an idea and builds it

The tools use the API models are trained for (OpenAI-style `tools` and `tool_calls`), so any
OpenAI-compatible server works.

## Make it yours

- Add a tool: search docs, run a linter, take a screenshot
- Add a skill: drop a SKILL.md in `workspace/skills/`
- Run the agent's commands in a throwaway VM or container instead of on your laptop
- Run several coders in parallel and keep the first one that passes
- Point it at your own repo
- Write up what you built on [DEV](https://dev.to)

## Options

- Any OpenAI-compatible server works. The talk ran on [ds4](https://github.com/antirez/ds4)
  serving DeepSeek V4 Flash (284B parameters, MIT license) on a 128 GB MacBook:
  `./ds4-server --ctx 32768`, which is the default `LLM_URL`.

## Presenting the talk

The slides are a [lookatme](https://github.com/d0c-s4vage/lookatme) deck with live terminals:

    uv tool install lookatme --python 3.11 \
      --build-constraints <(echo "cython<3") --constraints <(echo "urwid==2.1.2")
    ruby patch-lookatme.rb           # lets Up/Down scroll a finished terminal's output
    ./present                        # resets workspace/, then opens slides.md

On a terminal slide: Down to focus the terminal, Enter to run the pre-typed command, Up/Down to
scroll its output when it finishes, Right for the next slide. The deck expects at least 90x30.
