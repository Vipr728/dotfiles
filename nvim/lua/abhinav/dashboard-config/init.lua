 local home = os.getenv('HOME')
  local db = require('dashboard')
  db.session_directory = home .. '/.cache/nvim/session'
  db.preview_command = 'lolcat'
  db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
  db.preview_file_height = 6
  db.preview_file_width = 55
  db.custom_header = 
  db.custom_center = {
    {
      icon = '  ',
      desc = 'Update Plugins                          ',
      shortcut = 'SPC p u',
      action = 'PackerUpdate',
    },
    {
      icon = '  ',
      desc = 'Find  File                              ',
      action = 'Telescope find_files find_command=rg,--hidden,--files',
      shortcut = 'SPC f f',
    },
  } 
