return {
  opts = {
    statuscolumn = {
      enabled = true,
	   left = { "mark", "sign" }, -- priority of signs on the left (high to low)
  right = { "fold", "git" }, -- priority of signs on the right (high to low)
  folds = {
    open = true, -- show open fold icons
    git_hl = true, -- use Git Signs hl for fold icons
  },
  git = {
    patterns = { "GitSign", "MiniDiffSign" },
  },
  refresh = 1000,
    },
  },
}
