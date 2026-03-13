vim.env.PATH = "/home/gabry/.ghcup/bin:/home/gabry/.nimble/bin:" .. vim.env.PATH
vim.cmd "cd ~/Programming/"
vim.o.updatetime = 150
vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  signs = true,
}
vim.cmd "autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})"
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function() require("metals").initialize_or_attach {} end,
  group = nvim_metals_group,
})

local function SuW(_) vim.cmd "w !doas tee > /dev/null %" end

local function Ide(_)
  vim.cmd "Neotree"
  vim.cmd "wincmd l"
  vim.cmd "split"
  vim.cmd "terminal"
  vim.cmd "wincmd k"
  vim.cmd "resize 35"
end

local function DevC(_) require("devcontainer").commands.start_auto(nil, true) end

local function Dbg(_)
  vim.cmd "call vimspector#Launch()"
  vim.cmd "Neotree"
  vim.cmd "wincmd l"
end

vim.api.nvim_create_user_command("SuW", SuW, {})
vim.api.nvim_create_user_command("Ide", Ide, {})
vim.api.nvim_create_user_command("DevC", DevC, {})
vim.api.nvim_create_user_command("Dbg", Dbg, {})

vim.opt.mouse = nil
