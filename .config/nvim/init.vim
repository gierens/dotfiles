call plug#begin()
" Plug '~/Projects/neovim-plugin'
Plug 'gierens/neovim-plugin'

" Plug 'roxma/nvim-completion-manager'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'severin-lemaignan/vim-minimap'
" Plug 'takac/vim-hardtime'
Plug 'lervag/vimtex'

Plug 'williamboman/mason-lspconfig.nvim'
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'kaarmu/typst.vim'

" fzf
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
" Plug 'junegunn/fzf.vim'

" fugitive
Plug 'tpope/vim-fugitive'

" surround
Plug 'tpope/vim-surround'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'clangd/coc-clangd'
Plug 'fannheyward/coc-rust-analyzer'
Plug 'neoclide/coc-snippets'
Plug 'neoclide/coc-python'
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
Plug 'josa42/coc-sh'
Plug 'neoclide/coc-yaml'
Plug 'neoclide/coc-tsserver'
Plug 'neoclide/coc-git'
Plug 'iamcco/coc-spell-checker'
Plug 'iamcco/coc-cspell-dicts'
" Plug 'iamcco/coc-zi'
Plug 'Yggdroot/indentLine'
Plug 'fannheyward/coc-texlab'
Plug 'neoclide/coc-java'
Plug 'yaegassy/coc-ansible', {'do': 'yarn install --frozen-lockfile'}
" Plug 'weirongxu/coc-explorer'
" Plug 'neoclide/coc-highlight'
" TODO coc-lists
Plug 'neoclide/coc-pairs'

" NOTE install coc-word by
" :CocInstall coc-word

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'mengelbrecht/lightline-bufferline'
" TODO maybe compare to bufferline.nvim

" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'

" Plug 'udalov/kotlin-vim'
Plug 'sheerun/vim-polyglot'

" rust
Plug 'rust-lang/rust.vim'

" cmp
Plug 'hrsh7th/nvim-cmp'

" crates
" also requires 'nvim-lua/plenary.nvim'
Plug 'saecki/crates.nvim', { 'tag': 'v0.3.0' }

" also install hdl_checker
Plug 'suoto/hdlcc'

" cheat.sh
Plug 'RishabhRD/popfix'
Plug 'rishabhrd/nvim-cheat.sh'

" plenary
Plug 'nvim-lua/plenary.nvim'

" lua docs
Plug 'nanotee/luv-vimdocs'
Plug 'milisims/nvim-luaref'

" undotree
Plug 'mbbill/undotree'

" telescope
Plug 'nvim-telescope/telescope.nvim'
Plug 'debugloop/telescope-undo.nvim'

" easymotion
Plug 'easymotion/vim-easymotion'

" harpoon
" also requires nvim-lua/plenary.nvim
Plug 'ThePrimeagen/harpoon'

" vim-be-good
Plug 'ThePrimeagen/vim-be-good'

" GitHub Copilot
Plug 'github/copilot.vim'

" ChatGPT
Plug 'MunifTanjim/nui.nvim'
Plug 'jackMort/ChatGPT.nvim'

" RFC
Plug 'mhinz/vim-rfc'

" Todoist
Plug 'romgrk/todoist.nvim', { 'do': ':TodoistInstall' }

" Clap
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

" Calendar
Plug 'itchyny/calendar.vim'

" Visual Multi
Plug 'mg979/vim-visual-multi'

" Make it Rain
Plug 'eandrju/cellular-automaton.nvim'

" unicode
Plug 'chrisbra/unicode.vim'

" colorschemes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
call plug#end()

" transparent background
" au ColorScheme * hi Normal ctermbg=none guibg=none
" au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

" colorscheme and background based on time
if strftime("%H") > 7 && strftime("%H") < 16
    colorscheme gruvbox
    set background=light
else
    colorscheme gruvbox
    set background=dark
endif

" toggle background
call togglebg#map("<F5>")

" toggle highlight for searches
" let hlstate=0
" nnoremap <F4> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>
:nnoremap <TAB> :nohlsearch<CR><TAB>


" 80 char line
set colorcolumn=80
" highlight ColorColumn ctermbg=0 guibg=darkgrey

" tabs
set tabstop=4 shiftwidth=4 expandtab
"set tabstop=8 shiftwidth=8 noexpandtab

" line numbers
set number
set relativenumber
" highlight LineNr ctermfg=white ctermbg=0 guibg=darkgrey

" scroll window offset
set scrolloff=10

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, so coc-git does not overwrite the line numbers
set signcolumn=yes

" Highlight trailing whitespaces and other unwanted characters
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
"match ExtraWhitespace /\s\+$/
call matchadd('ExtraWhitespace', '\s\+$')
"call matchadd('ExtraWhitespace', ' ')
" Match all non-ASCII characters (including äöüß ...)
"call matchadd('ExtraWhitespace', '[^\u0000-\u007F]')

" persistent undo
set undodir=~/.nvim/undo
set undofile

" NerdTree Config
map <C-l> :NERDTreeToggle<CR>


" coc.nvim Config

" Use jj as <Esc> alternative
inoremap jj <ESC>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[d` and `]d` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" CoC Extensions
let g:coc_global_extensions = [ 'coc-clangd', 'coc-cspell-dicts', 'coc-emoji', 'coc-explorer', 'coc-fzf-preview', 'coc-git', 'coc-python', 'coc-sh', 'coc-snippets', 'coc-spell-checker', 'coc-sumneko-lua', 'coc-texlab', 'coc-tsserver', 'coc-word', 'coc-yaml', 'coc-zi' ]

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" coc-fzf-preview config
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>


" coc-texlab
:nmap <M-x> :CocCommand latex.Build<CR>

" coc-explorer
":nmap <C-n> :CocCommand explorer<CR>

" Vim Hardtime
" let g:hardtime_default_on = 1

"TODO
" coc-highlight Config
"autocmd CursorHold * silent call CocActionAsync('highlight')

" vimtex
let g:tex_flavor = 'latex'

" indentline
"let g:indentLine_leadingSpaceChar='·'
"let g:indentLine_leadingSpaceEnabled=1
let g:indentLine_fileTypeExclude = ['help', 'nerdtree']
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*']
let g:indentLine_char = '│'
"let g:indentLine_showFirstIndentLevel = 1
"let g:indentLine_first_char = '│'
" prevent conceal in tex files due to math fuck up
let g:indentLine_fileTypeExclude = ['tex']

" coc-git

" lightline
let g:lightline = {
  \ 'enable': {
  \   'statusline': 1,
  \   'tabline': 1,
  \ },
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'ctrlpmark', 'gitbranch', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'inactive': {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'percent' ],
  \              [ 'lineinfo' ] ]
  \ },
  \ 'tabline': {
  \   'left': [ [ 'buffers' ] ],
  \   'right': [ [ 'tabs' ] ]
  \ },
  \ 'component_function': {
  \   'blame': 'LightlineGitBlame',
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
\ }
let g:lightline#bufferline#min_buffer_count = 0
let g:lightline#bufferline#min_tab_count = 0
set showtabline=2

" set statusline^=%{get(g:,'coc_git_status','')}%{get(b:,'coc_git_status','')}%{get(b:,'coc_git_blame','')}

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" navigate conflicts of current buffer
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
" show chunk diff at current position
nmap <leader>gi <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap <leader>gS <Plug>(coc-git-commit)
" create text object for git chunks
omap <leader>if <Plug>(coc-git-chunk-inner)
xmap <leader>if <Plug>(coc-git-chunk-inner)
omap <leader>af <Plug>(coc-git-chunk-outer)
xmap <leader>af <Plug>(coc-git-chunk-outer)
" stage chuck at current position
nmap <leader>ga :CocCommand git.chunkStage<CR>
" unstage chuck at current position
nmap <leader>gr :CocCommand git.chunkUnstage<CR>
" undo chuck at current position
nmap <leader>gu :CocCommand git.chunkUndo<CR>
" push
" nmap <leader>gp :CocCommand git.push<CR>

" fugitive

" commit
nmap <leader>gg :Git 
nmap <leader>gs :Git status<CR>
nmap <leader>gA :Git add %<CR>
nmap <leader>gAA :Git add .<CR>
nmap <leader>gR :Git restore --staged %<CR>
nmap <leader>gc :Git commit --sign<CR>
nmap <leader>gC :Git commit --amend<CR>
nmap <leader>gp :Git push<CR>
" nmap <leader>gF :Git push --force<CR>
nmap <leader>gP :Git pull<CR>
nmap <leader>gm :Git merge --signoff --no-ff 
nmap <leader>gb :Git branch 
nmap <leader>gB :Git blame<CR>
nmap <leader>gd :Git diff<CR>
nmap <leader>gt :Git tag -fa 
nmap <leader>gw :Git stash<CR>
nmap <leader>gW :Git stash apply<CR>
nmap <leader>go :Git checkout 
nmap <leader>gO :Git checkout -b 
nmap <leader>gl :Git log<CR>
nmap <leader>gL :Git log --graph --oneline --decorate --all<CR>


" Further CoC Settings
let g:coc_filetype_map = { 'yaml.ansible': 'ansible' }


" reload config
nnoremap <leader>sv :source $MYVIMRC<CR>


" coc-snippets

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
"
" " Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)
"
" " Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
"
" " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'
"
" " Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)
"
" " Use <leader>x for convert visual selected code to snippet
" xmap <leader>x  <Plug>(coc-convert-snippet)

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
"
" let g:coc_snippet_next = '<tab>'


" coc-spell-checker
map <M-m> :CocCommand cSpell.toggleEnableSpellChecker<CR>
" TODO this is duplicated
vmap <leader>m <Plug>(coc-codeaction-selected)
nmap <leader>m <Plug>(coc-codeaction-selected)

" coc-pairs
autocmd FileType tex let b:coc_pairs = [["$", "$"]]

" rust.vim
syntax enable
filetype plugin indent on
let g:rustfmt_options = '--edition 2021'
let g:rustfmt_autosave = 1

" crates.nvim
lua require('crates').setup()

" cheat.sh
" vim.g.cheat_default_window_layout = 'split'
map <M-h> :Cheat 

" enable asm syntax for .asm files
autocmd BufNewFile,BufRead *.asm set syntax=asm

" enable tex syntax for .cls files
autocmd BufNewFile,BufRead *.cls set syntax=tex

" delete previous word in insert mode
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db " TODO does not work apparently

" telescope
lua <<EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
  }
}
EOF
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fr <cmd>Telescope resume<cr>
nnoremap <leader>fR <cmd>Telescope registers<cr>
nnoremap <leader>fu <cmd>Telescope undo<cr>
"
" " Using Lua functions
" nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>
" nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
" nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" harpoon
nnoremap <silent><leader>a :lua require("harpoon.mark").add_file()<cr>
nnoremap <silent><leader>e :lua require("harpoon.ui").toggle_quick_menu()<cr>
nnoremap <silent><leader>1 :lua require("harpoon.ui").nav_file(1)<cr>
nnoremap <silent><leader>2 :lua require("harpoon.ui").nav_file(2)<cr>
nnoremap <silent><leader>3 :lua require("harpoon.ui").nav_file(3)<cr>
nnoremap <silent><leader>4 :lua require("harpoon.ui").nav_file(4)<cr>
nnoremap <silent><leader>5 :lua require("harpoon.ui").nav_file(5)<cr>
nnoremap <silent><leader>6 :lua require("harpoon.ui").nav_file(6)<cr>
nnoremap <silent><leader>7 :lua require("harpoon.ui").nav_file(7)<cr>
nnoremap <silent><leader>8 :lua require("harpoon.ui").nav_file(8)<cr>
nnoremap <silent><leader>9 :lua require("harpoon.ui").nav_file(9)<cr>
nnoremap <silent><leader>0 :lua require("harpoon.ui").nav_file(0)<cr>

" Yank to clipboard
set clipboard+=unnamedplus

" execute line as command in bash
noremap <silent><leader>b :.!bash<cr>

" treesitter context
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "python", "rust", "lua", "vim" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "latex", },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua <<EOF
require'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
        },
        -- Patterns for specific filetypes
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        python = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
        },
        tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
        },
        rust = {
            'impl_item',
            'struct',
            'enum',
        },
        scala = {
            'object_definition',
        },
        vhdl = {
            'process_statement',
            'architecture_body',
            'entity_declaration',
        },
        markdown = {
            'section',
        },
        elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
        },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
}
EOF

" Visual Multi
" let g:VM_maps = {}
" let g:VM_maps['Find Under']         = '<C-l>'           " replace C-n
" let g:VM_maps['Find Subword Under'] = '<C-l>'           " replace visual C-n

" ChatGPT
lua <<EOF
config = require("chatgpt").setup({
    question_sign = "?",
    answer_sign = "!",
    chat_input = {
        prompt = " > ",
    }
})
EOF
map <M-g> :ChatGPT<CR>

" Terminal Emulator
map <M-t> :terminal<CR>

" Code Rain
map <M-r> :CellularAutomaton make_it_rain<CR>

" custom lua functions
lua <<EOF
P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end
EOF

" plenary
nmap <leader>t <Plug>PlenaryTestFile

" file manager
nmap <leader>s :Sex<CR>

" vim-rfc
nmap <leader>r :RFC 

" undotree
nnoremap <leader>u :UndotreeToggle<CR>

" typst
lua <<EOF
require('lspconfig').typst_lsp.setup{
    settings = {
        exportPdf = "onType" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
    }
}
EOF
