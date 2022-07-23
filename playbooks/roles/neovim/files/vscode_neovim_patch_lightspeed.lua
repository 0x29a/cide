-- stylua: ignore
local M = {}
local remap = _G.__light_speed_remap or {}
_G.__light_speed_remap = remap

local is_ls_start = false

M.setup = function()
    local is_vscode = vim.g.vscode == 1
    if not is_vscode then
        return
    end
    local api = vim.api
    local group_id = api.nvim_create_augroup('lightspeed_vscode', { clear = true })
    api.nvim_create_autocmd('User', {
        pattern = 'LightspeedEnter',
        group = group_id,
        callback = function()
            is_ls_start = true
        end,
    })
    api.nvim_create_autocmd('User', {
        pattern = 'LightspeedLeave',
        group = group_id,
        callback = function()
            is_ls_start = false
        end,
    })

    api.nvim_create_autocmd({ 'CursorMoved' }, {
        pattern = '*',
        group = group_id,
        callback = function()
            vim.fn.VSCodeExtensionNotify('visible-range')
        end,
    })
    -- hacking way on vim.fn.line
    remap.line = remap.line or vim.fn.line
    vim.fn.line = function(expr)
        if expr and is_ls_start then
            if expr == 'w$' and vim.b.vscode_range_endline ~= nil then
                return math.min(vim.b.vscode_range_endline + 2, remap.line('w$'))
            elseif expr == 'w0' and vim.b.vscode_range_startline ~= nil then
                return math.max(
                    math.min(vim.b.vscode_range_startline, remap.line('w0')),
                    1
                )
            end
        end
        return remap.line(expr)
    end
end

M.setup()
return M
