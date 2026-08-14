return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            table.insert(opts.sections.lualine_c, 1, {
                function()
                    return vim.fn.fnamemodify(LazyVim.root(), ":t")
                end,
            })
        end,
    },
}
