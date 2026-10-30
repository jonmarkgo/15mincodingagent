# patch-lookatme.rb: make Up/Down/PageUp/PageDown scroll an embedded terminal's output, both while
# its command runs and after it finishes (stock urwid sends arrows to the program, then ignores
# keys once it exits). Safe to run more than once.
#   ruby patch-lookatme.rb
vterm = Dir[File.expand_path("~/.local/share/uv/tools/lookatme/lib/python*/site-packages/urwid/vterm.py")].first
abort "lookatme's urwid not found; install lookatme first (see README)" unless vterm
source = File.read(vterm)

SCROLL = <<~PY
  if key in ("up", "down", "page up", "page down"):
      self.term.scroll_buffer(up=key in ("up", "page up"),
                              lines=1 if key in ("up", "down") else None)
      self._invalidate()
      return
PY

def patch(source, name, marker, from, to)
  return source.tap { puts "#{name}: already patched" } if source.include?(marker)
  old = Array(from).find { source.include?(_1) } or abort "#{name}: unexpected urwid version (code not found)"
  puts "#{name}: patched"
  source.sub(old, to)
end

# 1. After the command finishes, the arrows scroll instead of being ignored.
source = patch(source, "scroll when finished", "# talk patch: scroll finished terminals",
  "        if self.terminated:\n            return key\n",
  "        if self.terminated:\n            # talk patch: scroll finished terminals\n" +
  SCROLL.gsub(/^/, "            ") + "            return key\n")

# 2. While the command runs, the arrows scroll instead of being typed into it.
source = patch(source, "scroll while running", "# talk patch: scroll running terminals",
  "            self.touch_term(width, height)\n            return\n",
  "            self.touch_term(width, height)\n            return\n\n        # talk patch: scroll running terminals\n" +
  SCROLL.gsub(/^/, "        "))

# 3. Report no cursor when finished or scrolled. Scrolling hides the drawn cursor, and urwid's
#    ListBox aborts the whole deck if the reported and drawn cursor positions disagree.
source = patch(source, "no cursor when finished or scrolled", "# talk patch: no cursor when finished or scrolled",
  ["        if self.term is None or self.terminated:   # talk patch: no cursor when finished\n",
   "        if self.term is None:\n"],
  "        if self.term is None or self.terminated or self.term.scrolling_up:   # talk patch: no cursor when finished or scrolled\n")

File.write(vterm, source)
