return {
    {
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            servers = {
                emmet_ls = {
                    filetypes = {
                        "css",
                        "eruby",
                        "html",
                        "javascript",
                        "javascriptreact",
                        "less",
                        "sass",
                        "scss",
                        "svelte",
                        "pug",
                        "typescriptreact",
                        "vue",
                    },
                },
            },
        },
    },
}
