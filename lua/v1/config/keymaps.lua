require("v1.config.helpers.init")

-- -----------------------------------------------------------------------------------------------
-- General Keymaps
-- -----------------------------------------------------------------------------------------------

local keys = {

  -- Diagnostics
  Key:new("gl", "n", "Show Diagnostic", Diagnostics:show()),
  Key:new("<C-K>", "n", "LSP: Show [H]over", Diagnostics:hover()),
  Key:new("<leader>ud", "n", "Toggle [D]iagnostics", Diagnostics:toggle()),
  Key:new("[d", "n", "Go to previous diagnostic", Diagnostics:goto_prev()),
  Key:new("]d", "n", "Go to next diagnostic", Diagnostics:goto_next()),
  Key:new("<leader>ui", "n", "Toggle [I]nline Diagnostics", Diagnostics:toggle_inline()),

  -- Navitation
  Key:new("<C-a>", "n", "Select all", "ggVG", true),
  Key:new("E", { "n", "v", "s" }, "Move to end of line", "$", true),
  Key:new("B", { "n", "v", "s" }, "Move to beginning of line", "^", true),
  Key:new("QQ", "n", "Quit all", ":qa<CR>", true),
  Key:new("qq", "n", "Quit file", ":q<CR>", true),
  Key:new("WW", "n", "Save file", ":w<CR>", true),

  -- Movement
  Key:new("<C-h>", "n", "Move to the left window", "<cmd>TmuxNavigateLeft<CR>", true),
  Key:new("<C-j>", "n", "Move to the bottom window", "<cmd>TmuxNavigateDown<CR>", true),
  Key:new("<C-k>", "n", "Move to the top window", "<cmd>TmuxNavigateUp<CR>", true),
  Key:new("<C-l>", "n", "Move to the right window", "<cmd>TmuxNavigateRight<CR>", true),

  -- Finds
  Key:new("<leader>fi", "n", "[F]ind [I]cons", Find:icons()),
  Key:new("<leader>fh", "n", "[F]ind [H]elp", Find:help()),
  Key:new("<leader>fk", "n", "[F]ind [K]eymaps", Find:keymaps()),
  Key:new("<leader>fp", "n", "[F]ind [P]aths", Find:keymaps()),
  Key:new("<leader>fb", "n", "[F]ind [B]uiltin FZF", Find:builtin()),
  Key:new("<leader>fw", "n", "[F]ind current [W]ord", Find:current_word()),
  Key:new("<leader>fW", "n", "[F]ind current [W]ORD", Find:current_WORD()),
  Key:new("<leader>fG", "n", "[F]ind by Live [G]rep", Find:live_grep()),
  Key:new("<leader>fg", "n", "[F]ind by [G]rep", Find:grep()),
  Key:new("<leader>fd", "n", "[F]ind [D]iagnostics", Find:diagnostics()),
  Key:new("<leader>fr", "n", "[F]ind [R]esume", Find:resume()),
  Key:new("<leader>fo", "n", "[F]ind [O]ld Files", Find:old_files()),
  Key:new("<leader>/", "n", "[/] Live grep the current buffer", Find:live_grep_curbuf()),
  Key:new("<leader>fS", "n", "[F]ind Workspace [S]ymbols", Find:lsp_workspace_symbols()),
  Key:new("<leader>fs", "n", "[F]ind Document [S]ymbols", Find:lsp_document_symbols()),
  Key:new("<leader>ff", "n", "[F]ind [F]iles", Find:files()),
  Key:new("<leader>fl", "n", "[F]ind [L]ivewire ⚡️ Files", Find:livewire_files()),
  Key:new("<leader>fc", "n", "[F]ind [C]onfig files", Find:config_files()),
  Key:new("<leader><leader>", "n", "[,] Find existing buffers", Find:buffers()),
  Key:new("<leader>fm", "n", "[F]ind [M]essages", Find:notifications()),

  -- Todos
  Key:new("<leader>ft", "n", "[F]ind [T]odos, Fixmes, Hacks, ...", Find:todos()),
  Key:new("]t", "n", "Next todo comment", Jumps:todo_next()),
  Key:new("[t", "n", "Previous todo comment", Jumps:todo_prev()),

  -- Testing
  Key:new("<leader>tt", "n", "[T]oggle Neotest Summary", Tests:summary_toggle()),
  Key:new("<leader>ts", "n", "Run Test [S]uit", Tests:run_suite()),
  Key:new("<leader>tn", "n", "Run [N]earest test", Tests:run_nearest()),
  Key:new("<leader>tf", "n", "Run [F]ile tests", Tests:run_file()),
  Key:new("<leader>tl", "n", "Run [L]ast test", Tests:run_last()),
  Key:new("<leader>te", "n", "Stop [E]xecuting test", Tests:stop()),
  Key:new("<leader>ta", "n", "[A]ttach to test", Tests:attach()),
  Key:new("<leader>to", "n", "[o]pen test output", Tests:open_output()),
  Key:new("<leader>tO", "n", "T[O]ggle test output", Tests:toggle_output_panel()),

  -- Buffer Navigation
  Key:new("tb", "n", "List [B]uffers", ":ls<CR>", true),
  Key:new("tt", "n", "Go to last [T]buffer", ":b#<CR>", true),
  Key:new("tn", "n", "New [N]buffer", ":enew<CR>", true),
  Key:new("tk", "n", "Buffer [L]ast", ":blast<CR>", true),
  Key:new("tj", "n", "[F]irst buffer", ":bfirst<CR>", true),
  Key:new("th", "n", "Previous [H]buffer", ":bprev<CR>", true),
  Key:new("tl", "n", "Next [L]buffer", ":bnext<CR>", true),
  Key:new("td", "n", "[D]elete buffer", ":bdelete<CR>", true),

  -- UI
  Key:new("<leader>uc", "n", "Toggle [C]opilot", UI:toggle_copilot()),
  Key:new("<ESC>", "n", "Clear search highlights", "<cmd>nohlsearch<CR>", true),
  Key:new("jj", "i", "Exit insert mode", "<ESC>", true),
  Key:new("jk", "i", "Exit insert mode", "<ESC>", true),
  Key:new("<leader>ut", "n", "Toggle [T]wilight", UI:toggle_twilight()),
  Key:new("<leader>uw", "n", "Toggle Text [W]rap", UI:toggle_text_wrap()),
  Key:new("<leader>us", "n", "Toggle [S]treamer Mode", UI:streamer_mode()),

  -- Obsidian Notes
  Key:new("<leader>on", "n", "[O]bsidian [N]ew Note", Markdown:obsidian_create_note()),
  Key:new("<leader>os", "n", "[O]bsidian [S]earch Notes", Markdown:obsidian_search()),
  Key:new("<leader>og", "n", "[O]bsidian [G]rep Search", Markdown:obsidian_grep_search()),

  -- Harpoon
  Key:new("<space>j", "n", "[H]arpoon [P]revious", Harpoon:prev()),
  Key:new("<space>k", "n", "[H]arpoon [N]ext", Harpoon:next()),
  Key:new("<space>l", "n", "[H]arpoon [L]ist", Harpoon:list()),
  Key:new("<space>a", "n", "[H]arpoon [A]dd", Harpoon:add()),
  Key:new("<space>q", "n", "[H]arpoon [S]elect", Harpoon:select(1)),
  Key:new("<space>w", "n", "[H]arpoon [2]nd Select", Harpoon:select(2)),
  Key:new("<space>e", "n", "[H]arpoon [3]rd Select", Harpoon:select(3)),
  Key:new("<space>r", "n", "[H]arpoon [4]th Select", Harpoon:select(4)),
  Key:new("<space>t", "n", "[H]arpoon [5]th Select", Harpoon:select(5)),
}

Keymaps:load(keys)

-- Delete word in insert/visual mode
for _, mode in ipairs({ "i", "x" }) do
  vim.keymap.set(mode, "<C-BS>", "<C-w>", { silent = true })
end
vim.keymap.set("i", "<M-BS>", "<C-w>", { silent = true })

-- Keep selection after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- ------------------------------------------------------------------------------
-- Load keys when LSP is attached
-- ------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("keymaps-lsp-attach", { clear = true }),
  callback = function()
    local lsp_keys = {
      Key:new("gd", "n", "[G]oto [D]efinition(s)", LSP:definitions()),
      Key:new("gD", "n", "[G]oto [D]eclaration", LSP:declaration()),
      Key:new("gr", "n", "[G]oto [R]eference(s)", LSP:references()),
      Key:new("gI", "n", "[G]oto [I]mplementation(s)", LSP:implementations()),
      Key:new("<leader>D", "n", "Type [D]efinition", LSP:type_definition()),
      Key:new("<leader>cr", "n", "[R]ename", LSP:rename()),
      Key:new("<leader>ca", { "n", "x" }, "[C]ode [A]ction", LSP:code_action()),
    }

    Keymaps:load(lsp_keys)

    -- Remove potential conflicts with other plugins
    for _, keymap in ipairs({ "grr", "gra", "gri", "grn" }) do
      pcall(vim.keymap.del, "n", keymap)
    end
  end,
})

---------------------------------------------------------------------------------------------------
-- Markdown / Obsidian specific keymaps
-- Only load when a markdown file is opened
---------------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.md",
  callback = function()
    if Markdown:obsidian_is_inside_inbox() then
      Keymaps:load({
        Key:new("<leader>ok", "n", "Set Note as O[K]", Markdown:obsidian_move_to_zettelkasten()),
      })
    end

    Keymaps:load({
      -- Markdown
      Key:new("<leader>mt", "n", "[M]arkdown [T]odo", Markdown:new_todo()),
      Key:new("<leader>mn", "n", "[M]arkdown [N]ext Todo", Markdown:next_todo()),
      Key:new("<leader>mp", "n", "[M]arkdown [P]revious Todo", Markdown:previous_todo()),
      Key:new("<leader>or", "n", "So[R]t todo list", Markdown:sort_todos()),

      -- Obsidian
      Key:new("<leader>od", "n", "Toggle [CH]eckbox", Markdown:obsidian_toggle_checkbox()),
      Key:new("<leader>ot", "n", "[T]able of contents", Markdown:obsidian_toc()),
      Key:new("<leader>oa", "n", "[A]pply default template", Markdown:obsidian_template_note()),
      Key:new("<leader>of", "n", "[F]ollow Link", Markdown:obsidian_follow_link()),
    })
  end,
})
