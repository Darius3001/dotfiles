return {
    { "towolf/vim-helm" },
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
                tsserver = {
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                },
                gopls = {
                    filetypes = { "go", "gomod", "gowork", "gotmpl" },
                },
            },
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
    },
    {
        "MunifTanjim/prettier.nvim",
        filetypes = {
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "json",
            "scss",
            "less",
        },
    },
}
