return {
    'nvim-pack/nvim-spectre',
    config = function()
        local spectre = require("spectre")

        vim.keymap.set("n", "<leader>S", spectre.toggle, { desc = "toggle Spectre" })
        vim.keymap.set("n", "<leader>sw",
            function()
                spectre.open_visual({ select_word = true })
            end, { desc = "toggle Spectre" })
        vim.keymap.set("n", "<leader>sp",
            function()
                spectre.open_file_search({ select_word = true })
            end, { desc = "toggle Spectre" })
        vim.keymap.set("v", "<leader>sw", function()
            spectre.open_visual()
        end, { desc = "toggle Spectre" })
    end
}
