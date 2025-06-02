-- lua/mazen/run_code.lua

local M = {}

-- Function to run the current file based on filetype
local function RunCode()
    local filetype = vim.bo.filetype
    local filepath = vim.fn.expand('%:p')
    local filename = vim.fn.expand('%:t')
    local filedir = vim.fn.expand('%:p:h')
    local basefilename = vim.fn.expand('%:t:r') -- Filename without extension

    -- Commands to execute in terminal
    local command = ''

    if filetype == 'c' then
        command = string.format('gcc %s -o %s && ./%s', filename, basefilename, basefilename)
    elseif filetype == 'cpp' then
        -- Using -std=c++17 or similar is often needed in competitive programming
        -- Add common flags like -Wall -Wextra -O2 -fsanitize=address,undefined -D_GLIBCXX_DEBUG
        local cpp_flags = '-std=c++17 -Wall -Wextra -O2' -- Add or change flags as needed
        command = string.format('g++ %s %s -o %s && ./%s', filename, cpp_flags, basefilename, basefilename)
    elseif filetype == 'java' then
        -- Running from a file with main()
        command = string.format('javac %s && java %s', filename, basefilename)
    elseif filetype == 'python' then
        command = string.format('python %s', filename)
    -- Add other languages if needed
    -- elseif filetype == 'go' then
    --     command = string.format('go run %s', filename)
    -- elseif filetype == 'rust' then
    --     command = string.format('rustc %s && ./%s', filename, basefilename)
    end

    if command ~= '' then
        -- Save the current file
        vim.cmd('w')
        -- Change directory to the file's directory before running
        local cd_command = string.format('cd %s', filedir:gsub(' ', '\\ ')) -- Handle spaces in path
        local final_command = string.format('%s && %s', cd_command, command)

        -- Open a terminal buffer and execute the command
        vim.cmd('split new') -- Open a new horizontal split for the terminal
        vim.cmd('terminal ' .. final_command)
    else
        vim.notify("Running this filetype is not configured.", vim.log.levels.WARN)
    end
end

-- Map a key to the function (e.g., F5)
vim.keymap.set('n', '<F5>', RunCode, { desc = 'Compile and Run Current File' })

-- Alternative mapping using leader key
-- vim.keymap.set('n', '<leader>r', RunCode, { desc = 'Compile and Run Current File' })

return M
