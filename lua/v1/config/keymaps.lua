-- Open parent directory of current file
-- vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- Buffer navigation
local buffer_keys = {
  tb = { ":ls<CR>", "List buffers" },
  tt = { ":b#<CR>", "Go to last buffer" },
  tn = { ":enew<CR>", "New buffer" },
  tk = { ":blast<CR>", "Buffer Last" },
  tj = { ":bfirst<CR>", "First buffer" },
  th = { ":bprev<CR>", "Previous buffer" },
  tl = { ":bnext<CR>", "Next buffer" },
  td = { ":bdelete<CR>", "Delete buffer" },
}
for k, v in pairs(buffer_keys) do
  vim.keymap.set("n", k, v[1], { silent = true, desc = v[2] })
end

-- Movement
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { silent = true, desc = "Move to the left window" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { silent = true, desc = "Move to the bottom window" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { silent = true, desc = "Move to the top window" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { silent = true, desc = "Move to the right window" })

-- Navigation
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
vim.keymap.set({ "n", "v", "s" }, "E", "$", { desc = "End of line" })
vim.keymap.set({ "n", "v", "s" }, "B", "^", { desc = "Beginning of line" })
vim.keymap.set("n", "QQ", ":qa<CR>", { desc = "Quit everything" })
vim.keymap.set("n", "qq", ":q<CR>", { desc = "Quit file" })
vim.keymap.set("n", "WW", ":w<CR>", { desc = "Save File" })

-- Diagnostics
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
vim.keymap.set("n", "<C-K>", vim.lsp.buf.hover, { desc = "LSP: Show [H]over" })
vim.keymap.set("n", "<Leader>ud", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle [D]iagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
-- display inline
vim.keymap.set("n", "<Leader>ui", function()
  vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "Toggle [I]nline Diagnostics" })

-- Delete word in insert/visual mode
for _, mode in ipairs({ "i", "x" }) do
  vim.keymap.set(mode, "<C-BS>", "<C-w>", { silent = true })
end
vim.keymap.set("i", "<M-BS>", "<C-w>", { silent = true })

-- Clear search highlights
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>")

-- LSP FZF keymaps (attach only when LSP is active)
local function lsp_goto(method, fallback, fzf_func, msg)
  return function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, method, params, function(_, result)
      local items = type(result) == "table" and (result.result or result) or nil
      if not items or vim.tbl_isempty(items) then
        vim.notify("No " .. msg .. " found", vim.log.levels.ERROR)
      elseif #items == 1 then
        fallback(params)
      else
        require("fzf-lua")[fzf_func]()
      end
    end)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("keymaps-lsp-attach", { clear = true }),
  callback = function()
    vim.keymap.set(
      "n",
      "gd",
      lsp_goto("textDocument/definition", vim.lsp.buf.definition, "lsp_definitions", "definition"),
      { desc = "[G]oto [D]efinition(s)" }
    )
    for _, keymap in ipairs({ "grr", "gra", "gri", "grn" }) do
      pcall(vim.keymap.del, "n", keymap)
    end
    vim.keymap.set("n", "gr", function()
      require("fzf-lua").lsp_references()
    end, { desc = "[G]oto [R]eference(s)" })
    vim.keymap.set(
      "n",
      "gI",
      lsp_goto("textDocument/implementation", vim.lsp.buf.implementation, "lsp_implementations", "implementation"),
      { desc = "[G]oto [I]mplementation(s)" }
    )
    vim.keymap.set("n", "gD", function()
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      for _, client in ipairs(clients) do
        if client.supports_method("textDocument/declaration") then
          lsp_goto("textDocument/declaration", vim.lsp.buf.declaration, "lsp_declarations", "declaration")()
          return
        end
      end
      vim.notify("LSP method textDocument/declaration not supported", vim.log.levels.ERROR)
    end, { desc = "[G]oto [D]eclaration" })
    vim.keymap.set("n", "<leader>D", require("fzf-lua").lsp_typedefs, { desc = "Type [D]efinition" })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename" })
    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
  end,
})

-- FZF keymaps
local fzf = require("fzf-lua")

local fzf_keys = {
  ["<leader>fh"] = { fzf.helptags, "[F]ind [H]elp" },
  ["<leader>fk"] = { fzf.keymaps, "[F]ind [K]eymaps" },
  -- ["<leader>ff"] = { fzff.frecency({ cwd_only = true }), "[F]ind [F]iles" },
  ["<leader>fp"] = { "<cmd>FzfDirectories<CR>", "[F]ind [P]aths" },
  ["<leader>fb"] = { fzf.builtin, "[F]ind [B]uiltin FZF" },
  ["<leader>fw"] = { fzf.grep_cword, "[F]ind current [W]ord" },
  ["<leader>fW"] = { fzf.grep_cWORD, "[F]ind current [W]ORD" },
  ["<leader>fG"] = { fzf.live_grep, "[F]ind by Live [G]rep" },
  ["<leader>fg"] = { fzf.grep_project, "[F]ind by [G]rep" },
  ["<leader>fd"] = { fzf.diagnostics_document, "[F]ind [D]iagnostics" },
  ["<leader>fr"] = { fzf.resume, "[F]ind [R]esume" },
  ["<leader>fo"] = { fzf.oldfiles, "[F]ind [O]ld Files" },
  ["<leader><leader>"] = { fzf.buffers, "[,] Find existing buffers" },
  ["<leader>/"] = { fzf.lgrep_curbuf, "[/] Live grep the current buffer" },
  ["<leader>fS"] = { require("fzf-lua").lsp_workspace_symbols, "[F]ind Workspace [S]ymbols" },
  ["<leader>fs"] = { require("fzf-lua").lsp_document_symbols, "[F]ind Document [S]ymbols" },
}
for k, v in pairs(fzf_keys) do
  vim.keymap.set("n", k, v[1], { desc = v[2] })
end

-- FREQUENCY
vim.keymap.set("n", "<leader>ff", function()
  require("fzf-lua-frecency").frecency({ cwd_only = true })
end, { desc = "[F]ind [F]iles" })
-------------------

-- Search livewire bolt files easily
vim.keymap.set("n", "<leader>fl", function()
  fzf.files({ query = "⚡️" })
end, { desc = "[F]ind [L]ivewire ⚡️ Files" })

vim.keymap.set("n", "<leader>fc", function()
  fzf.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[F]ind Neovim [C]onfig files" })

vim.keymap.set("n", "<leader>fD", function()
  fzf.files({ cwd = os.getenv("HOME") .. "/dotfiles" })
end, { desc = "[F]ind [D]otfiles" })

vim.keymap.set("n", "<leader>ft", function()
  require("todo-comments.fzf").todo()
end, { desc = "[F]ind [T]odos, Fixmes, Hacks, ..." })

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Toggle undotree
-- vim.keymap.set("n", "<leader>uu", function()
--   vim.cmd.UndotreeToggle()
--   vim.cmd.UndotreeFocus()
-- end, { desc = "Toggle [U]ndoTree [U]i" })

-- Keep selection after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Toggle copilot completion
vim.keymap.set("n", "<leader>uc", function()
  vim.g.copilot_completion_enabled = not vim.g.copilot_completion_enabled
  if vim.g.copilot_completion_enabled then
    vim.cmd("Copilot enable")
    vim.notify("Copilot enabled", vim.log.levels.INFO)
  else
    vim.cmd("Copilot disable")
    vim.notify("Copilot disabled", vim.log.levels.WARN)
  end
end, { desc = "Toggle [C]opilot" })

-- Easy escapes
for _, seq in ipairs({ "jj", "jk" }) do
  vim.keymap.set("i", seq, "<ESC>", { silent = true, desc = "Exit insert mode" })
end

-- Twilight
vim.keymap.set("n", "<leader>ut", function()
  require("twilight").toggle()
end, { desc = "Toggle [T]wilight" })

-- Nerdy
vim.keymap.set("n", "<leader>fi", "<cmd>Nerdy<CR>", { desc = "[F]ind [I]cons" })

-- Toggle Text Wrap
vim.keymap.set("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle Text [W]rap" })

---------------------------------------------------------------------------------------
-- NeoTests
vim.keymap.set("n", "<leader>tt", function()
  require("neotest").summary.toggle()
end, { desc = "[T]oggle Neotest Summary" })

vim.keymap.set("n", "<leader>ts", function()
  require("neotest").run.run("tests")
end, { desc = "Run Test [S]uit" })

vim.keymap.set("n", "<leader>tn", function()
  require("neotest").run.run()
end, { desc = "run [N]earest test" })

vim.keymap.set("n", "<leader>tf", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run [F]ile tests" })

vim.keymap.set("n", "<leader>tl", function()
  require("neotest").output_panel.clear()
  require("neotest").run.run_last()
end, { desc = "Run [L]ast test" })

vim.keymap.set("n", "<leader>te", function()
  require("neotest").run.stop()
end, { desc = "Stop [E]xecuting test" })

vim.keymap.set("n", "<leader>ta", function()
  require("neotest").run.attach()
end, { desc = "[A]ttach to test" })

vim.keymap.set("n", "<leader>to", function()
  require("neotest").output.open({ enter = true })
end, { desc = "[o]pen test output" })

vim.keymap.set("n", "<leader>tO", function()
  require("neotest").output_panel.toggle()
end, { desc = "T[O]ggle test output" })

-- vim.keymap.set("n", "<leader>tg", ":vsplit<CR>:A<CR>", { desc = "[G]oto test file" })
