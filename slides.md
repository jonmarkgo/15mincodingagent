---
title: Building a Local Coding Agent in 15 Minutes
author: Jon Gottfried, MLH
date: 2026-10-30
styles:
  # MLH colors on dark: yellow #F8B92A and red #E73427 (blue #1D539F is too dim on black)
  style: monokai
  title: {fg: "#fb2,bold", bg: "default"}
  author: {fg: "#e32", bg: "default"}
  date: {fg: "#777", bg: "default"}
  slides: {fg: "#fb2,bold", bg: "default"}
  link: {fg: "#fb2,underline", bg: "default"}
  headings:
    "1": {fg: "#fb2,bold", bg: "default", prefix: "██ ", suffix: ""}
    "2": {fg: "#e32,bold", bg: "default", prefix: "▓▓▓ ", suffix: ""}
  bullets: {"1": "■", default: "■"}
  padding:
    left: 4
    right: 4
    top: 0
    bottom: 0
---

```
 ▓▓      ▓▓▓▓   ▓▓▓▓▓  ▓▓▓▓  ▓▓
██▒     ████▒▓ █████  ████▒▓██▒
██▒    ██▒ ██▒██▒    ██▒▓██▒██▒
██▒    ██▒ ██▒██▒    ██████▒██▒
██▒▓▓▓▓██▒▓██ ██▒▓▓▓▓██▒ ██▒██▒▓▓▓▓
██████  ████   █████ ██  ██ ██████
  ▓▓▓▓▓  ▓▓▓▓  ▓▓▓▓▓  ▓▓▓▓▓▓ ▓▓  ▓▓  ▓▓▓▓▓
 █████  ████▒▓█████▒▓██████ ██▒▓██▒ █████
██▒    ██▒ ██▒██▒ ██▒  ██▒  ███▒██▒██▒ ▓▓▓
██▒    ██▒ ██▒██▒ ██▒  ██▒  ██████▒██▒███▒
██▒▓▓▓▓██▒▓██ ██▒▓██  ▓██▒▓▓██▒███▒██▒▓██▒
 █████  ████  █████  ██████ ██  ██  █████
  ▓▓▓▓   ▓▓▓▓▓ ▓▓▓▓▓▓ ▓▓  ▓▓ ▓▓▓▓▓▓
 ████▒▓ █████ ██████ ██▒▓██▒██████
██▒▓██▒██▒ ▓▓▓██▒▓▓  ███▒██▒  ██▒
██████▒██▒███▒████   ██████▒  ██▒
██▒ ██▒██▒▓██▒██▒▓▓▓▓██▒███▒  ██▒
██  ██  █████ ██████ ██  ██   ██
```

**Building a local coding agent in 15 minutes.**

Jon Gottfried, Co-Founder, Major League Hacking

---

# Hacktoberfest 2026: AI belongs to everyone

```
 ▓▓▓▓▓▓  ▓▓▓▓   ▓▓▓▓                   ▓▓    ▓▓▓▓   ▓▓▓▓  ▓▓  ▓▓
██████  ████▒▓ ████▒▓   ▓▓            ██▒   ████▒▓ ████▒▓██▒ ██
██▒▓▓▓ ██▒ ██▒██▒ ██▒ ▓██▒▓▓         ███▒  ██▒ ██▒██▒ ██▒██▒██
█████▒▓██▒ ██▒██▒ ██▒██████           ██▒  ██▒ ██▒██▒ ██▒████▒▓
 ▓▓▓██ ██▒▓██ ██▒▓██   ██             ██▒▓ ██▒▓██ ██▒▓██ ██▒██▒▓
█████   ████   ████                  ████   ████   ████  ██  ██

 events worldwide                    people learning
```

People all over the world learning **open source** and **open-weight LLMs and AI**.

- Run by MLH and DEV, presented by DigitalOcean
- No pull-request counting this year: **learn, build, and share in the open**
- Today you're at one of those 500+ events, right here in Brooklyn

---

# How I learned: a loop

```
._                       _.     .----------------------------.
 \`-._   .-------.   _.-'/      | STAR WARS RULEZ! [-][o][x] |░
  `-. `-/         \-' .-'       |----------------------------|░
     `-| (o)   (o) |-'          | >> PUNCH THE MONKEY! <<    |░
       |     ^     |            | You are visitor #000042    |░
        \  `---'  /             | o==[]::::::::::::::>       |░
         `-.....-'              | /!\ UNDER CONSTRUCTION /!\ |░
        /|       |\             '----------------------------'░
       /_|       |_\             ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

 "Copy-paste, you will.
  Break it, you must."
```

- Copy some Perl into my Star Wars site. Run it. **Read the error.** Change one thing. Run it again.
- The big unlock: **submit a form, do something with the result**
<!-- stop -->
- That's how people learn and get things done: **try, look at the result, adjust, repeat**
<!-- stop -->
- An agent is that same loop, in code. **That's what we'll build.**

---

# AI made code cheap

Anyone in this room can generate an app today. What sets you apart: **your ideas**, and **understanding the machine.**

<!-- stop -->

```
   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒
████████████████████▒▒▒
████████████████████▒▒▒
████████    ████████▒▒▒
████████ ?? ████████▒▒▒
████████    ████████▒▒
████████████████████▒
████████████████████
```

A **harness** is the code around a model that lets it act: tools, a loop, rules. Claude Code and Cursor are harnesses, and they're black boxes. **You can use them. You can't open them.**

---

# What is an LLM?

A **statistical predictor of text.** Given the words so far, it picks a likely next word. Then it does it again.

```
 "The capital of France is"   ─▶  " Paris"          (very likely)
 puts "Hello, #{               ─▶  name             (very likely)
```

<!-- stop -->

- It learned those odds from a huge amount of text and code
- The odds live in billions of numbers: the **weights** (here, an 81 GB file)
- **Text in, text out.** That's the whole interface.

---

# What's an open-weight model?

| | Claude, Gemini, GPT | Open weights, on your laptop |
| --- | --- | --- |
| Where it runs | Their servers | Your machine |
| What you get | Answers, over the internet | The model itself: a file (this one is 81 GB) |
| Account, internet | Required | Neither |
| Cost | Pay per token | Your electricity |
| Your data | Leaves your machine | Stays put |
| Open it up, change it | No | Yes: inspect it, fine-tune it, build on it |
| Smartest today | Yes | Close behind |

<!-- stop -->

Same HTTP call either way. **The agent we're about to build works with both.**

---

# Let's build a simple coding agent

Live. Offline. One idea per slide, each building on the last. **The terminals are real.**

1. Inference is an HTTP call
2. Tools are plain Ruby methods
3. Describe the tools, then ask with them
4. The model asks, Ruby acts
5. Guardrails
6. The loop

Then: put it all together and build something.

---

# Wifi: off. Prove it.

The internet is gone. The model is still here.

```file
path: steps/offline.sh
relative: true
lang: bash
lines:
  start: 2
  end: 5
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 16
init_text: steps/offline.sh
init_wait: '$ '
init_codeblock: false
```

---

# 1 · Inference is an HTTP call

Like submitting a form and doing something with the result.

```file
path: steps/01_ask.rb
relative: true
lang: ruby
lines:
  start: 4
  end: 16
```

---

# 1 · Run it

```file
path: steps/01_ask.rb
relative: true
lang: ruby
lines:
  start: 17
  end: 21
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 18
init_text: "ruby steps/01_ask.rb \"Hacktoberfest 2026: zero PRs, 500+ events on open-source AI. Explain it as a pirate, in one line.\""
init_wait: '$ '
init_codeblock: false
```

---

# Your turn: what should we ask it?

Step 1's ask in a loop is a chatbot. **An agent is a loop too.**

```file
path: steps/chat.rb
relative: true
lang: ruby
lines:
  start: 3
  end: 15
```

---

# Your turn: run it

DeepSeek V4 Flash: 284B parameters, MIT license, wifi still off.

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 20
init_text: ruby steps/chat.rb
init_wait: '$ '
init_codeblock: false
```

---

# What can it do, and what can't it?

Predict text well enough and you can **write code, explain it, plan.** But can it *do* things?

```file
path: steps/hallucinate.rb
relative: true
lang: ruby
lines:
  start: 4
  end: 16
```

---

# What can it do: run it

Here's greet.rb, the script we'll ask about:

```file
path: workspace/greet.rb
relative: true
lang: ruby
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 17
init_text: ruby steps/hallucinate.rb
init_wait: '$ '
init_codeblock: false
```

That's a **hallucination**. **To do things, it needs tools.**

---

# 2 · Tools: reading

The model only sends back text. **These methods are the only way it can do anything.**

```file
path: steps/02_tools.rb
relative: true
lang: ruby
lines:
  start: 5
  end: 14
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 9
init_text: "ruby -r ./steps/02_tools.rb -e 'puts read_file(\"path\" => \"greet.rb\")'"
init_wait: '$ '
init_codeblock: false
```

---

# 2 · Tools: writing

Add a line to greet.rb. **An append is just a read plus a write.**

```file
path: steps/02_tools.rb
relative: true
lang: ruby
lines:
  start: 15
  end: 19
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 15
init_text: "ruby -r ./steps/02_tools.rb -e 'old = read_file(\"path\" => \"greet.rb\"); puts write_file(\"path\" => \"greet.rb\", \"content\" => old + \"puts %(Built offline!)\\n\")'"
init_wait: '$ '
init_codeblock: false
```

---

# 3 · Describe the tools

The model can't see your Ruby. You tell it what each of step 2's methods does.
The last one, **run_shell**, is the powerful one. We'll come back to it.

```file
path: steps/03_describe.rb
relative: true
lang: ruby
lines:
  start: 4
  end: 19
```

---

# How does it understand tools?

It doesn't, the way Ruby does. **Tools become more text in its prompt.** ds4 adds this:

```
 ## Tools
 You have access to a set of tools to help answer the user question.
 You can invoke tools by writing a "<|DSML|tool_calls>" block ...
 ### Available Tool Schemas
 {"name": "read_file", "description": "Read a file", ...}   ← TOOL_SPECS
```

<!-- stop -->

And the model writes back plain text, in that format:

```
 <|DSML|tool_calls>
 <|DSML|invoke name="read_file">
 <|DSML|parameter name="path" string="true">greet.rb</|DSML|parameter>
 </|DSML|invoke>
 </|DSML|tool_calls>
```

<!-- stop -->

It learned that format from huge numbers of examples, so **a tool call is just the most likely next text.** ds4 spots it and hands Ruby the JSON.

---

# How does it decide which tool to use?

You hand it a menu. It reads your task, reads the menu, and predicts the best next move.

```
 task: "Read greet.rb"
 menu: list_files · read_file · write_file · run_shell
 most likely next move ─▶ "read_file, path: greet.rb"
```

<!-- stop -->

- Modern models are trained on huge numbers of examples of exactly this
- It's still a prediction, not a promise. **So Ruby checks before it acts.**

---

# 3 · Ask with the tools

Step 1's ask, now with tools: the job, then the task.

```file
path: steps/03_describe.rb
relative: true
lang: ruby
lines:
  start: 20
  end: 30
```

---

# 3 · Run it

**It sends back a request. Nothing happens yet.**

```file
path: steps/03_describe.rb
relative: true
lang: ruby
lines:
  start: 31
  end: 37
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 14
init_text: ruby steps/03_describe.rb "Read greet.rb"
init_wait: '$ '
init_codeblock: false
```

---

# 4 · The model asks, Ruby acts

Take the request from step 3, check the name, **call that step 2 method.**

```file
path: steps/04_act.rb
relative: true
lang: ruby
lines:
  start: 3
  end: 18
```

---

# 4 · Run it

Same request as step 3. **This time Ruby does it.**

```file
path: steps/04_act.rb
relative: true
lang: ruby
lines:
  start: 19
  end: 23
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 15
init_text: ruby steps/04_act.rb "Read greet.rb"
init_wait: '$ '
init_codeblock: false
```

---

# One more tool: running commands

Run greet.rb: there's our bug. Any command at all, **which is why step 5 exists.**

```file
path: steps/02_tools.rb
relative: true
lang: ruby
lines:
  start: 20
  end: 25
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 14
init_text: "ruby -r ./steps/02_tools.rb -e 'puts run_shell(\"command\" => \"ruby greet.rb\")'"
init_wait: '$ '
init_codeblock: false
```

---

# 5 · Guardrails

Checks in front of step 4's run_tool. Running a .rb file in the folder is fine. **Anything else needs a human.**

```file
path: steps/05_guardrails.rb
relative: true
lang: ruby
lines:
  start: 3
  end: 18
```

---

# 5 · Run it

```file
path: steps/05_guardrails.rb
relative: true
lang: ruby
lines:
  start: 19
  end: 23
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 17
init_text: ruby steps/05_guardrails.rb "What version of Ruby is installed?"
init_wait: '$ '
init_codeblock: false
```

---

# What's an agent loop?

```
   ┌──▶ ask the model, with everything so far
   │          │
   │          ├── asks for a tool?  ─▶  Ruby runs it  ─▶  add the result ──┐
   │          │                                                             │
   │          └── just answers?     ─▶  done                                │
   └────────────────────────────────────────────────────────────────────────┘
```

<!-- stop -->

- Every turn it sees the task, its own requests and every result
- That's how it debugs: it **reads the error** and tries again
- A step limit stops it from going forever

<!-- stop -->

**That loop? That was me as a kid:** run it, read the error, change one thing. Now code runs the loop.

The pieces, from earlier steps:

```ruby
messages = start(task)                    # step 3: the job + the task
reply    = ask(messages, tools: TOOL_SPECS)  # step 3: ask with tools
result   = act(call)                      # step 4: run what it asked for
```

---

# 6 · The loop: send results back until it's done

```file
path: steps/06_loop.rb
relative: true
lang: ruby
lines:
  start: 3
  end: 20
```

---

# 6 · Run it

A fresh folder with the bug, then one task. **Nobody tells it what's wrong.**

```file
path: steps/06_loop.rb
relative: true
lang: ruby
lines:
  start: 21
  end: 25
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 15
init_text: "ruby steps/06_loop.rb \"Run greet.rb and fix it if it's broken.\""
init_wait: '$ '
init_codeblock: false
```

---

# Extend it: skills

A file of instructions the agent reads when it's relevant. **No new code. No new tools.**

```
 skills/readme/SKILL.md
 ---
 name: readme
 description: How to write the README for a small Ruby script
 ---
 Write README.md with exactly these three sections: ...
```

<!-- stop -->

- Up front, the agent only sees each skill's **name and description**
- When a task needs one, it reads the whole file with step 2's **read_file**
- Same idea as Claude Code skills, AGENTS.md and CLAUDE.md

---

# Extend it: MCP servers

MCP is a standard way for **any program to offer tools** to any agent.

```
 our agent                        an MCP server (GitHub, Figma, a database...)

 TOOL_SPECS  ◀── tools/list ────  "here are my tools, described"
 run a tool  ─── tools/call ───▶  runs it, sends back the result
```

<!-- stop -->

- It's steps 2, 3 and 4, living in someone else's program
- Plug one in and your agent gets new tools **without writing new Ruby**

---

# Put it all together: build something

**Room vote:** a quiz score grader · a BMI calculator · a rock paper scissors judge

```file
path: steps/build.rb
relative: true
lang: ruby
lines:
  start: 3
  end: 9
```

```terminal-ex
command: bash --rcfile steps/stage.bashrc -i
rows: 12
init_text: ruby steps/build.rb
init_wait: '$ '
init_codeblock: false
```

---

# What you just built

```
 task ─▶ MODEL ─▶ asks for a tool ─▶ RUBY runs it ─▶ result
           ▲                                           │
           └─────────────────── loop ◀─────────────────┘
```

| Ours | Claude Code, Codex, Cursor |
| --- | --- |
| HTTP to a model on this laptop | HTTP to a model in the cloud |
| 4 tools | Dozens: edit, search, web, MCP |
| The loop | The same loop |
| A safe list + a human | Permission prompts, sandboxes |

**You just built a harness**, in about 200 lines of plain Ruby. Understand this one and you understand them.

---

# Code is cheap. Understanding isn't.

Anyone can vibe code an app now.

<!-- stop -->

Far fewer people can build the things that build apps: **the tools, the systems, the agents.**

<!-- stop -->

**That's your leg up.** You just watched one get built in about 200 lines.

---

# Your challenge today

- Next: Hastimal shows you **Gemma 4** running on your own laptop
<!-- stop -->
- Point this agent at it: `LLM_URL=http://localhost:11434/v1 LLM_MODEL=gemma4`
<!-- stop -->
- Give it a new tool: **search the web docs**, **run the linter**, **take a screenshot**
<!-- stop -->
- Or build your own tool for a track: **Education**, **Healthcare**, **Entertainment**

**github.com/jonmarkgo/15mincodingagent**

---

# What to do at Hacktoberfest

Not counting pull requests. **Building in the open.**

- Build something today, and push it to GitHub
- Write up what you learned on **DEV**
- Help the person next to you get their agent running

```
           ▓▓▓
          ███▒
    ▓▓▓▓▓▓▓██▒▓▓▓▓▓▓▓▓
  ▓██████████████████▒▓▓
 ██████  ██████  ██████▒▓
█████    ██████    █████▒
████████████████████████▒
████  ██  ████  ██  ████
 ██████          ██████
   ██████████████████
```

