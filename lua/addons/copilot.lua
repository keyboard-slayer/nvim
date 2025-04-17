return {
    {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup({
                panel = {
                    enabled = false,
                },
                suggestion = {
                    enabled = false,
                },
            })
        end,
    },
    {
        "giuxtaposition/blink-cmp-copilot",
    },
}
