return {
    { "Mofiqul/dracula.nvim" },
    {
        "vermdeep/darcula_dark.nvim",
        lazy = false,
        priority = 1002,
    },
    {
        "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
        dependencies = {
            "vermdeep/darcula_dark.nvim",
        },
    },
}
