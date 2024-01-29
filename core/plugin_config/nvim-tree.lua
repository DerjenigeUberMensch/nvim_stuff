vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_auto_reload_on_write = 1
require("nvim-tree").setup{}


vim.g.nvim_tree_respect_buf_cwd = 1
--Makes non-context file opening; ie if you open a file at c:/Windows 
--But the file is in c:/Desktop/nvim/plugins;
--it still shows the relative file tree c:/dekstop/nvim/plugins
--without it it would just show c:/windows because thats where you opened it
--P.S just dont remove this option (disabled by default.)

local statusFlag = false
local initializedStatus = false
function GoToNerdTree()
    if(not initializedStatus) then
        vim.cmd[[:NvimTreeFindFileToggle]]
        initializedStatus = true
        return
    end
    if(statusFlag) then

        statusFlag = not statusFlag
        vim.cmd[[:NvimTreeFindFile]]
    else
        vim.cmd[[:NvimTreeFocus]]
    end
end
vim.keymap.set('n', '<c-x>', ':lua GoToNerdTree()<CR>')

