# dotfiles

Personal config for macOS, Arch Linux, and Windows/WSL-style shells.

## Platform notes

- Neovim config is shared across platforms. Plugin build steps include Windows guards where needed.
- Tmux status scripts support macOS (`Darwin`), Linux (`/proc`), and Windows-ish shells (`MSYS`, `MINGW`, `CYGWIN`) where available.
- Tmux clipboard copy prefers `pbcopy`, then `wl-copy`, `xclip`, `xsel`, then `clip.exe`.
- Ghostty config is mainly for macOS/Linux Ghostty. macOS-only options live in the Ghostty config and should be ignored only by Ghostty-compatible installs.
- Machine-local and imported Claude/Codex state stays ignored.
