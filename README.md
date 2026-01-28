# Neovim Configuration

Configuração pessoal e modular do Neovim, otimizada para desenvolvimento PHP/Laravel, JavaScript/TypeScript, Go e Lua.

## Estrutura do Projeto

```
nvim/
├── init.lua                 # Ponto de entrada
├── lua/v1/
│   ├── setup.lua           # Sequência de inicialização
│   ├── lazy.lua            # Configuração do plugin manager
│   ├── util.lua            # Funções utilitárias
│   ├── config/
│   │   ├── options.lua     # Opções do Vim
│   │   ├── keymaps.lua     # Keybindings globais
│   │   ├── commands.lua    # Comandos customizados
│   │   ├── autocmds/       # Auto comandos
│   │   └── helpers/        # Módulos auxiliares
│   ├── plugins/            # Configurações de plugins
│   ├── snippets/           # Snippets customizados
│   └── lsp/                # Configurações de LSP
├── lsp/                    # LSPs customizados
└── after/                  # Configurações pós-plugin
```

## Requisitos

- Neovim >= 0.10
- Git
- [Nerd Font](https://www.nerdfonts.com/) instalada
- Node.js (para LSPs JavaScript/TypeScript)
- ripgrep (para buscas)

## Instalação

```bash
# Clone o repositório
git clone https://github.com/r2luna/nvim ~/.config/nvim

# Abra o Neovim (plugins serão instalados automaticamente)
nvim
```

## Plugin Manager

Utiliza [lazy.nvim](https://github.com/folke/lazy.nvim) com:
- Bootstrap automático
- Carregamento lazy por evento/filetype
- UI com bordas arredondadas

## Plugins Principais

### LSP & Completion
| Plugin | Descrição |
|--------|-----------|
| nvim-lspconfig | Cliente LSP |
| blink.cmp | Engine de completion (Rust-based) |
| mason.nvim | Gerenciador de LSPs e ferramentas |
| lazydev.nvim | LSP para config Neovim em Lua |
| laravel.nvim | Suporte Laravel |

### Navegação & Busca
| Plugin | Descrição |
|--------|-----------|
| telescope.nvim | Fuzzy finder |
| mini.files | Explorador de arquivos |
| harpoon | Marcação de arquivos por projeto |
| flash.nvim | Movimentação rápida |

### Git
| Plugin | Descrição |
|--------|-----------|
| gitsigns.nvim | Diff/blame no gutter |
| lazygit.nvim | UI do Git |
| vim-fugitive | Comandos Git |

### Testes
| Plugin | Descrição |
|--------|-----------|
| neotest | Framework de testes |
| neotest-phpunit | Adapter PHPUnit |
| neotest-pest | Adapter Pest |

### Edição
| Plugin | Descrição |
|--------|-----------|
| conform.nvim | Formatador de código |
| nvim-autopairs | Auto-fechar brackets |
| nvim-surround | Surround text objects |
| Comment.nvim | Comentários |

### UI
| Plugin | Descrição |
|--------|-----------|
| lualine.nvim | Status line |
| which-key.nvim | Sugestões de keymaps |
| nvim-notify | Notificações |
| snacks.nvim | Utilitários de UI |

### AI
| Plugin | Descrição |
|--------|-----------|
| supermaven-nvim | Completion com IA |

## Keymaps

**Leader Key:** `,` (vírgula)

### Navegação

| Keymap | Ação |
|--------|------|
| `<C-h/j/k/l>` | Navegação entre janelas (Tmux-aware) |
| `<leader>e` | Abrir explorador de arquivos |
| `<leader>a` | Adicionar arquivo ao Harpoon |
| `<leader>l` | Lista do Harpoon |
| `<leader>j/k` | Próximo/anterior no Harpoon |
| `<space>q/w/e/r/t` | Arquivos Harpoon 1-5 |

### Busca (Telescope)

| Keymap | Ação |
|--------|------|
| `<leader>ff` | Buscar arquivos |
| `<leader>fb` ou `<leader><leader>` | Buscar buffers |
| `<leader>fg` | Grep live |
| `<leader>fw` | Buscar palavra sob cursor |
| `<leader>fd` | Buscar diagnósticos |
| `<leader>fr` | Retomar última busca |
| `<leader>fo` | Arquivos recentes |
| `<leader>fh` | Buscar help |
| `<leader>fk` | Buscar keymaps |
| `<leader>fs` | Símbolos do documento |
| `<leader>ft` | Buscar TODOs |

### LSP & Código

| Keymap | Ação |
|--------|------|
| `gd` | Ir para definição |
| `gr` | Ir para referências |
| `gI` | Ir para implementação |
| `<leader>ca` | Code action |
| `<leader>cr` | Renomear |
| `<leader>cf` | Formatar buffer |
| `<leader>D` | Type definition |
| `gl` | Mostrar diagnósticos |
| `[d` / `]d` | Diagnóstico anterior/próximo |

### Testes

| Keymap | Ação |
|--------|------|
| `<leader>tt` | Toggle sumário de testes |
| `<leader>ts` | Rodar suite de testes |
| `<leader>tn` | Rodar teste mais próximo |
| `<leader>tf` | Rodar testes do arquivo |
| `<leader>tl` | Rodar último teste |
| `<leader>to` | Abrir output |

### Git

| Keymap | Ação |
|--------|------|
| `<leader>gg` | Abrir LazyGit |
| `<leader>gb` | Checkout branch |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gp` | Preview hunk |
| `<leader>gl` | Blame da linha |
| `<leader>gj/gk` | Próximo/anterior hunk |

### UI Toggles

| Keymap | Ação |
|--------|------|
| `<leader>ud` | Toggle diagnósticos |
| `<leader>ui` | Toggle diagnósticos inline |
| `<leader>uh` | Toggle inlay hints |
| `<leader>ut` | Toggle Twilight (modo foco) |
| `<leader>uz` | Toggle Zen mode |
| `<leader>uw` | Toggle word wrap |

### PHP Tools

| Keymap | Ação |
|--------|------|
| `<leader>pm` | Gerar método PHP |
| `<leader>pc` | Gerar classe PHP |
| `<leader>pn` | Namespace PHP |
| `<leader>pf` | Criar arquivo PHP |

### Outros

| Keymap | Ação |
|--------|------|
| `jj` / `jk` | Sair do modo insert |
| `<C-a>` | Selecionar tudo |
| `QQ` | Quit all |
| `WW` | Salvar arquivo |
| `<leader>s` | Flash jump |
| `<leader>S` | Flash Treesitter |

## Language Servers

### LSPs Configurados
- **TypeScript/JavaScript:** ts_ls
- **Lua:** lua_ls
- **PHP:** intelephense
- **Go:** gopls
- **Tailwind CSS:** tailwindcss-language-server
- **Vue:** vue-language-server
- **HTML/CSS:** html-languageserver, css-languageserver
- **JSON/YAML:** jsonls, yamlls
- **Docker:** dockerls, docker_compose_language_service
- **Bash:** bashls, shellcheck
- **SQL:** sqlls
- **C/C++:** clangd
- **TOML:** taplo

### Formatadores (Conform.nvim)
- **Lua:** stylua
- **JS/TS/JSON/MD/HTML/CSS/YAML:** prettier
- **PHP:** pint
- **Go:** goimports, gofmt
- **Shell:** shfmt
- **SQL:** sqlfmt

## Tema

Utiliza [pinnord.nvim](https://github.com/r2luna/pinnord.nvim) com:
- Background transparente
- Bordas arredondadas
- Status line transparente

## Features

- Números de linha relativos
- Auto-format ao salvar
- Auto-save ao perder foco
- Persistência de sessão
- Highlight ao copiar (yank)
- Restauração da última posição do cursor
- Remoção de whitespace ao salvar
- Code folding com Treesitter
- Integração com Obsidian para notas

## Customização

### Opções do Editor
As opções principais estão em `lua/v1/config/options.lua`:
- Tab = 4 espaços
- Clipboard sincronizado com OS
- Mouse habilitado
- Preview incremental de comandos

### Adicionando Plugins
Crie um arquivo em `lua/v1/plugins/` seguindo o padrão lazy.nvim:

```lua
return {
  "autor/plugin",
  event = "VeryLazy",
  config = function()
    require("plugin").setup({})
  end,
}
```

## Licença

MIT
