local options = {
    number = true,
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 0,
    expandtab = true,
    expandtab = true,
    clipboard = "unnamedplus",
    cmdheight = 1,
    fileencoding = "utf-8",
    hlsearch = true,
    showmode = false,
    smartcase = true,
    smartindent = true,
    splitbelow = true,
    splitright = true,
    undofile = true,
    updatetime = 300,
    writebackup = false,
    wrap = true,
    linebreak = true,
    guifont = "Comic Mono:h17",
    whichwrap = "bs<>[]hl",
    guicursor = ""
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.o.termguicolors = true
