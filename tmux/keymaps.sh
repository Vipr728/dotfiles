#!/usr/bin/env bash

D=$'\033[38;5;243m'
G=$'\033[38;5;114m'
Y=$'\033[38;5;223m'
T=$'\033[38;5;253m'
R=$'\033[0m'

k() { printf "${D}%-14s ${D}│${R}  ${G}%-14s${R} ${T}%s${R}\n" "$1" "$2" "$3"; }

{
# ── PREFIX TABLE (Ctrl+F then key) ─────────────────

# Sessions
k "session" "K" "quick session picker (minimal)"
k "session" "T" "session picker (preview + kill)"
k "session" "n" "new session (named)"
k "session" "s" "choose session tree"
k "session" "(" "previous session"
k "session" ")" "next session"
k "session" "L" "last session (toggle)"
k "session" "\$" "rename session"
k "session" "D" "choose/detach client"

# Windows
k "window" "c" "new window"
k "window" "[" "previous window"
k "window" "]" "next window"
k "window" "p" "previous window"
k "window" "0-9" "go to window number"
k "window" "'" "go to window by index"
k "window" "w" "choose window tree"
k "window" "f" "find window"
k "window" "," "rename window"
k "window" "&" "kill window (confirm)"
k "window" "." "move window"
k "window" "<" "window context menu"
k "window" "Space" "next layout"

# Panes
k "pane" "|" "split right"
k "pane" "-" "split down"
k "pane" "w" "kill pane"
k "pane" "o" "next pane (cycle)"
k "pane" ";" "last pane (toggle)"
k "pane" "q" "show pane numbers"
k "pane" "!" "break pane to window"
k "pane" "{" "swap pane up"
k "pane" "}" "swap pane down"
k "pane" "M" "mark pane"
k "pane" ">" "pane context menu"
k "pane" "C-o" "rotate panes"

# Zoom / Resize
k "zoom" "m" "zoom / maximize pane"
k "zoom" "z" "zoom / maximize pane"
k "resize" "Up" "resize up 5"
k "resize" "Down" "resize down 5"
k "resize" "Left" "resize left 5"
k "resize" "Right" "resize right 5"
k "resize" "C-Up" "resize up 1"
k "resize" "C-Down" "resize down 1"
k "resize" "C-Left" "resize left 1"
k "resize" "C-Right" "resize right 1"

# Navigation (no prefix — vim-tmux-navigator)
k "navigate" "C-h" "pane left  (no prefix)"
k "navigate" "C-j" "pane down  (no prefix)"
k "navigate" "C-k" "pane up  (no prefix)"
k "navigate" "C-l" "pane right  (no prefix)"

# Layouts
k "layout" "M-1" "even-horizontal"
k "layout" "M-2" "even-vertical"
k "layout" "M-3" "main-horizontal"
k "layout" "M-4" "main-vertical"
k "layout" "M-5" "tiled"
k "layout" "M-6" "main-horiz mirrored"
k "layout" "M-7" "main-vert mirrored"
k "layout" "E" "spread panes evenly"

# Copy / Scroll (enter)
k "scroll" "v" "enter copy mode"
k "scroll" "u" "copy mode + scroll up"
k "scroll" "PgUp" "copy mode + scroll up"
k "scroll" "#" "list paste buffers"
k "scroll" "=" "choose paste buffer"

# Popups
k "popup" "C-t" "floating terminal"
k "popup" "C-g" "floating lazygit"
k "popup" "t" "theme switcher (menu)"
k "popup" "d" "config editor menu"
k "popup" "?" "this keymaps help"

# Plugins (TPM)
k "plugin" "I" "install plugins (tpm)"
k "plugin" "U" "update plugins (tpm)"
k "plugin" "M-u" "clean plugins (tpm)"

# Resurrect
k "resurrect" "C-s" "save session"
k "resurrect" "C-r" "restore session"

# Misc
k "misc" "r" "reload config"
k "misc" ":" "command prompt"
k "misc" "i" "display pane info"
k "misc" "t" "clock mode"
k "misc" "~" "show messages log"
k "misc" "C" "customize mode"
k "misc" "C-z" "suspend tmux client"
k "misc" "C-l" "send C-l (clear)"
k "misc" "/" "describe key binding"

# ── COPY MODE VI (inside copy mode) ───────────────

# Movement
k "vi:move" "h" "cursor left"
k "vi:move" "j" "cursor down"
k "vi:move" "k" "cursor up"
k "vi:move" "l" "cursor right"
k "vi:move" "w" "next word"
k "vi:move" "b" "previous word"
k "vi:move" "e" "next word end"
k "vi:move" "W" "next WORD"
k "vi:move" "B" "previous WORD"
k "vi:move" "E" "next WORD end"
k "vi:move" "0" "start of line"
k "vi:move" "\$" "end of line"
k "vi:move" "^" "first non-blank"
k "vi:move" "H" "top of screen"
k "vi:move" "M" "middle of screen"
k "vi:move" "L" "bottom of screen"
k "vi:move" "g" "top of history"
k "vi:move" "G" "bottom of history"
k "vi:move" ":" "goto line number"
k "vi:move" "o" "other end of selection"
k "vi:move" "%" "matching bracket"

# Scrolling
k "vi:scroll" "C-u" "half page up"
k "vi:scroll" "C-d" "half page down"
k "vi:scroll" "C-b" "full page up"
k "vi:scroll" "C-f" "full page down"
k "vi:scroll" "C-y" "scroll up 1 line"
k "vi:scroll" "C-e" "scroll down 1 line"
k "vi:scroll" "J" "scroll down"
k "vi:scroll" "K" "scroll up"
k "vi:scroll" "z" "scroll to center"
k "vi:scroll" "PgUp" "page up"
k "vi:scroll" "PgDn" "page down"

# Searching
k "vi:search" "/" "search forward"
k "vi:search" "?" "search backward"
k "vi:search" "n" "next match"
k "vi:search" "N" "previous match"
k "vi:search" "*" "search word forward"
k "vi:search" "#" "search word backward"

# Jumping
k "vi:jump" "f{c}" "jump forward to char"
k "vi:jump" "F{c}" "jump backward to char"
k "vi:jump" "t{c}" "jump to before char"
k "vi:jump" "T{c}" "jump to after char"
k "vi:jump" ";" "repeat last jump"
k "vi:jump" "," "reverse last jump"
k "vi:jump" "{" "previous paragraph"
k "vi:jump" "}" "next paragraph"
k "vi:jump" "X" "set mark"
k "vi:jump" "M-x" "jump to mark"

# Selection & Copy
k "vi:select" "v" "begin selection"
k "vi:select" "Space" "begin selection"
k "vi:select" "V" "select line"
k "vi:select" "C-v" "rectangle toggle"
k "vi:select" "y" "yank to clipboard"
k "vi:select" "Enter" "copy and cancel"
k "vi:select" "D" "copy to end of line"
k "vi:select" "A" "append and cancel"
k "vi:select" "P" "toggle position info"
k "vi:select" "r" "refresh from pane"

# Exit
k "vi:exit" "q" "cancel / exit"
k "vi:exit" "Esc" "cancel / exit"
k "vi:exit" "C-c" "cancel / exit"

} | fzf --ansi --reverse --no-sort \
    --prompt '  ' \
    --header-first \
    --header $'\n   TMUX KEYMAPS · prefix: Ctrl+F\n   ──────────────────────────────────────────\n   vi:* keys are inside copy mode (Ctrl+F v)\n' \
    --bind 'enter:abort,esc:abort' \
    --no-info \
    --pointer '▶' \
    --margin 0,1 \
    --color 'bg:#1e1e2e,fg:#cdd6f4,header:#89b4fa:bold,prompt:#cba6f7,pointer:#f5e0dc,hl:#a6e3a1,hl+:#a6e3a1,border:#585b70,bg+:#313244,fg+:#cdd6f4'
