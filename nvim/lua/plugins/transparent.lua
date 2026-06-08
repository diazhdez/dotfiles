return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalFloat",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "TelescopeNormal",
        "TelescopeBorder",
        "WhichKeyFloat",
      },
    })
    -- Activa transparencia automáticamente al iniciar
    vim.cmd("TransparentEnable")
  end,
}
