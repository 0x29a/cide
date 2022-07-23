require "user.plugins"

-- https://github.com/vscode-neovim/vscode-neovim/pull/868#issuecomment-1131963354
require "user.vscode_neovim_patch_lightspeed"
vim.cmd[[hi LightspeedCursor gui=reverse]]

-- TODO:
-- Create fork with https://github.com/vscode-neovim/vscode-neovim/pull/869 
-- and bild the extension manually.
