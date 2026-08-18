if not os.getenv("DISPLAY") then
    vim.cmd.colorscheme("wildcharm")
else
    -- https://github.com/rebelot/kanagawa.nvim
    require("plugman").add(
        { host = "https://github.com", owner = "rebelot", repo = "kanagawa.nvim", name = "kanagawa" },
        {
            functionStyle = { bold = true, italic = true },
            typeStyle = { bold = true },
            dimInactive = true,
        },
        function()
            vim.cmd.colorscheme("kanagawa-dragon")
        end
    )
end
