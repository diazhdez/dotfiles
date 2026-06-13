-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all text" })

vim.keymap.set("n", "<leader>h", function()
  local ok = pcall(function()
    Snacks.dashboard()
  end)
  if not ok then
    vim.cmd("Alpha")
  end
end, { desc = "Dashboard" })
