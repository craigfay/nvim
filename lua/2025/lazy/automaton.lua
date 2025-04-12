return {
    "eandrju/cellular-automaton.nvim",
    config = function ()
        vim.keymap.set("n", "<leader>ca", "CellularAutomaton game_of_life")
    end
}
