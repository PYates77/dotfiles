return {
	{ "axelf4/vim-strip-trailing-whitespace", event = "BufReadPre" },
    { "kwkarlwang/bufjump.nvim", event = "VeryLazy", opts = {} },
    { "nmac427/guess-indent.nvim", event = "BufReadPost" },
    { "folke/flash.nvim", event = "VeryLazy", opts = {},
        keys = {
            -- remap flash s/S to gs/gS (conflicts with surround)
            { "s", mode = { "n", "x", "o" }, false },
            { "S", mode = { "n", "x", "o" }, false },
            { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "gS", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
    { -- since we rebound 'flash' off these, we can now restore the normal mini.surround keybinds
        "nvim-mini/mini.surround",
        opts = {
            mappings = {
                add = "sa", -- Add surrounding in Normal and Visual modes
                delete = "sd", -- Delete surrounding
                find = "sf", -- Find surrounding (to the right)
                find_left = "sF", -- Find surrounding (to the left)
                highlight = "sh", -- Highlight surrounding
                replace = "sr", -- Replace surrounding
                update_n_lines = "sn", -- Update `n_lines`
            },
        },
    },
    --{
    --    "kylechui/nvim-surround",
    --    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    --    event = "VeryLazy",
    --    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    --    -- config = function()
    --    --     require("nvim-surround").setup({
    --    --         -- Put your configuration here
    --    --     })
    --    -- end
    --},
}
