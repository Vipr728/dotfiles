    return {
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
          latex = { enabled = true },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "jbyuki/nabla.nvim",
        keys = {
          { "<leader>le", function() require("nabla").popup() end, desc = "LaTeX equation popup" },
          { "<leader>lv", function() require("nabla").toggle_virt() end, desc = "Toggle LaTeX virtual text" },
        },
      },
    }

