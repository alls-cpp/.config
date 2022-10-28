local function map(m, k, v)
    vim.api.nvim_set_keymap(m, k, v, { silent = true })
end

-- jk for change mode
map('i', 'jk', '<ESC>')

-- Move line up and down in NORMAL and VISUAL modes
map('n', '<C-j>', ':move .+1<CR>')
map('n', '<C-k>', ':move .-2<CR>')
map('x', '<C-j>', ":move '>+1<CR>gv=gv")
map('x', '<C-k>', ":move '<-2<CR>gv=gv")

-- Autocompletion
map('n', '<Tab>', '<C-N>')

-- Use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map('o', 'A', ':<C-U>normal! mzggVG<CR>`z')
map('x', 'A', ':<C-U>normal! ggVG<CR>')

-- Find and replace
map('n', '<C-S>', ':%s/');

-- Import function
map('n', '<C-L>', ':r ~/Library/');

-- cpbooster
    -- Test solution with testcase
    map('n', '<F10>', ':Test<CR>')
    map('i', '<F10>', '<ESC> :Test<CR>')

    -- Debug one testcase
    map('n', '<F11>', ':Debug ')
    map('i', '<F11>', '<ESC> :Debug ')

    -- Submit the solution online
    map('n', '<F12>', ':Submit<CR>')
    map('i', '<F12>', '<ESC> :Submit<CR>')

