return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gdscript = {
        settings = {
          gdscript = {
            -- Make sure this port matches the one in your godot editor settings
            port = 6005,
          }
        }
      }
    }
  }
}
