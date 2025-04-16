return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = { section_separators = "", component_separators = "" },
      sections = {
        lualine_b = { "branch", "diagnostics" },
        lualine_c = {
          "%=",
          {
            "tabs",
            mode = 1,
            path = 1,
            symbols = {
              modified = "",
            },
            fmt = function(name, context)
              -- Show + if buffer is modified in tab
              local buflist = vim.fn.tabpagebuflist(context.tabnr)
              local winnr = vim.fn.tabpagewinnr(context.tabnr)
              local bufnr = buflist[winnr]
              local mod = vim.fn.getbufvar(bufnr, "&mod")

              local bold_name = "%#LualineBoldFileName#" .. name .. "+%*"
              if mod == 1 then
                return bold_name
              else
                return name
              end
            end,
          },
        },
      },
    })

    vim.api.nvim_set_hl(0, "LualineBoldFileName", { bold = true, fg = "#FFFFFF" }) -- White bold text
  end,
}
