local options = {
    clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
    fileencoding = "utf-8",                  -- the encoding written to a file
    showtabline = 2,                         -- always show tabs
    swapfile = false,                        -- creates a swapfile
    undofile = true,                         -- enable persistent undo
    writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 2,                          -- the number of spaces inserted for each indentation
    tabstop = 2,                             -- insert 2 spaces for a tab
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
