-- Neovim config, ported from my old .vimrc (plugins left out for now).
-- Neovim already defaults to: nocompatible, hidden, utf-8, backspace=indent,eol,start,
-- laststatus=2, filetype plugin indent on, syntax on.

-- Use ripgrep for :grep
vim.opt.grepprg = 'rg --vimgrep --smart-case --follow'

-- Line numbers and spell check
vim.opt.number = true
vim.opt.spell = true
vim.api.nvim_set_hl(0, 'SpellBad', { underline = true, bold = true, fg = 'red', ctermfg = 'red' })

-- Indent with 2 spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Flag trailing whitespace
vim.api.nvim_set_hl(0, 'BadWhitespace', { bg = 'darkred', ctermbg = 'red' })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  command = [[match BadWhitespace /\s\+$/]],
})

-- Leader is space
vim.g.mapleader = ' '

-- Split navigation with leader
for _, key in ipairs({ 'h', 'j', 'k', 'l' }) do
  vim.keymap.set('n', '<leader>' .. key, '<C-W>' .. key)
  vim.keymap.set('n', '<leader>' .. key:upper(), '<C-W>' .. key:upper())
end

-- Open new splits to the right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Status line: file, type, line position
vim.opt.ruler = false
vim.opt.statusline = '%f %y editing line %-4l/ %-4L'

-- Python language servers (built-in LSP, no plugins): pyright for types,
-- completion and go-to-definition; ruff for lint and format. Neovim's default
-- maps cover the rest: K hover, grn rename, gra code action, grr references.
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'requirements.txt', '.git' },
  settings = { python = { analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true } } },
  -- Use the project's uv venv when there is one
  before_init = function(_, config)
    local python = config.root_dir and config.root_dir .. '/.venv/bin/python'
    if python and vim.uv.fs_stat(python) then
      config.settings.python.pythonPath = python
    end
  end,
})
vim.lsp.config('ruff', {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
})
vim.lsp.enable({ 'pyright', 'ruff' })

-- Format the buffer with the language server (ruff for Python)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
