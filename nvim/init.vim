call plug#begin('~/.vim/plugged')
"=========================基礎設定=====================================
Plug 'tpope/vim-surround'                                             | "符號補全
Plug 'scrooloose/nerdcommenter'                                       | "註解快捷
Plug 'kien/ctrlp.vim'                                                 | "模糊搜尋
Plug 'majutsushi/tagbar'                                              | "Outliner
Plug 'farmergreg/vim-lastplace'                                       | "最後的編輯位置
Plug 'tpope/vim-fugitive'                                             | "Git工具
Plug 'easymotion/vim-easymotion'                                      | "超速移動
Plug 'rhysd/open-pdf.vim'                                             | "PDF閱讀器
"=========================終端操作===================================== 
Plug 'christoomey/vim-tmux-navigator'                                 | "視窗間移動
Plug 'jpalardy/vim-slime'                                             | "程式碼傳遞至終端
Plug 'kassio/neoterm'                                                 | "終端重複利用
"=========================外觀與狀態===================================
Plug 'vim-airline/vim-airline'                                        | "狀態列
Plug 'vim-airline/vim-airline-themes'                                 | "狀態列主題
Plug 'joshdick/onedark.vim'                                           | "主題設定
Plug 'sheerun/vim-polyglot'                                           | "圖形支援
Plug 'airblade/vim-gitgutter'                                         | "Git狀態
Plug 'ryanoasis/vim-devicons'                                         | "圖示支援
Plug 'scrooloose/nerdtree'                                            | "檔案樹
Plug 'luochen1990/rainbow'                                            | "彩色括弧
Plug 'yggdroot/indentline'                                            | "縮排線
"=========================語法設定=====================================
Plug 'plasticboy/vim-markdown'                                        | "Markdown語法高亮
Plug 'godlygeek/tabular'                                              | "Markdown語法表格
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'} | "Markdown結果顯示
Plug 'JuliaEditorSupport/julia-vim'                                   | "Julia語法高亮
Plug 'Vimjas/vim-python-pep8-indent'                                  | "Python 縮排指南
Plug 'heavenshell/vim-pydocstring', {'do': 'make install'}            | "Python 說明文件字串支援
Plug 'elzr/vim-json'                                                  | "Json語法高亮
Plug 'mattn/emmet-vim'                                                | "Html標籤快捷
Plug 'neoclide/coc.nvim', {'branch': 'release'}                       | "自動補全
Plug 'itchyny/vim-cursorword'                                         | "將光標位置的文字劃上底線
call plug#end()

"+---------------+
"| basic setting |
"+---------------+ 
inoremap <silent>jk <Esc>
command! W w
nnoremap <silent>qq :wqa<CR>
set nowrap
set nu
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set relativenumber
set cursorline
colorscheme onedark
set tabstop=4
set shiftwidth=4
set ai
set smarttab
set incsearch
set nowrapscan
set nobackup
set nowritebackup
set backspace=indent,eol,start
set splitbelow
set splitright
set display+=lastline
set ruler
syntax on
filetype indent on
filetype off
set wildmenu
set wildmode=full
set scrolloff=4
let &t_ut=''
let g:onedark_allpw_italics = 1
let g:airline_theme = 'onedark'
if (has("termguicolors"))
  set termguicolors
endif
let g:rainbow_active = 0
let g:indentLine_enabled = 0
let g:indentLine_char_list = ['|']

"+---------+
"| neoterm |
"+---------+
let g:neoterm_default_mod = "below"
let g:neoterm_bracketed_paste = 1
let g:neoterm_size = 12 
nnoremap ` :Ttoggle<CR>
vnoremap <leader>` :TREPLSendSelection<CR>
nnoremap <leader>` :TREPLSendLine<CR>

autocmd TermOpen * setlocal nonumber norelativenumber

tnoremap <silent>jk <C-\><C-n>
tnoremap <C-j> <C-\><C-n>:TmuxNavigateDown<CR>
tnoremap <C-k> <C-\><C-n>:TmuxNavigateUp<CR>
tnoremap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
tnoremap <C-l> <C-\><C-n>:TmuxNavigateRight<CR>

"+------------+
"| easymotion |
"+------------+
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
map  / <Plug>(easymotion-sn)
map  n <Plug>(easymotion-next)

" Move to line
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

"+----------+
"| nerdtree |
"+----------+
nmap <F2> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1

"+--------+
"| tagbar |
"+--------+
nmap <F3> :TagbarToggle<CR>

"+-------------+
"| vim-airline |
"+-------------+
let g:airline#extensions#tabline#enabled = 1
nnoremap <leader><CR> :bnext<CR>
nnoremap <leader><backspace> :bprevious<CR>
nmap <leader>1 :bfirst<CR>
nmap <leader>2 :bfirst<CR>:bn<CR>
nmap <leader>3 :bfirst<CR>:2bn<CR>
nmap <leader>4 :bfirst<CR>:3bn<CR>
nmap <leader>5 :bfirst<CR>:5bn<CR>
nmap <leader>6 :bfirst<CR>:6bn<CR>
nmap <leader>7 :bfirst<CR>:7bn<CR>
nmap <leader>8 :bfirst<CR>:8bn<CR>
nmap <leader>9 :bfirst<CR>:9bn<CR>

"+-------+
"| emmet |
"+-------+
xmap <leader>, <C-Y>,

"+------------------+
"| markdown setting |
"+------------------+
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_json_frontmatter = 1

"+----------------+
"| python setting |
"+----------------+
let g:pydocstring_doq_path = "/home/larvasei/Database/Sei/bin/doq"
let g:pydocstring_formatter = 'google'
nmap <leader>ss <Plug>(pydocstring)
au FileType python exec "1T ipython"

"+---------------+
"| julia setting |
"+---------------+
let g:syntastic_julia_checkers = 1
let g:latex_to_unicode_tab = 1
inoremap <C-TAB> <C-X><C-O>
runtime macros/matchit.vim
au VimEnter,BufRead,BufNewFile *.jl set filetype=julia
au FileType julia exec "1T julia"

"+-----------+
"| gitgutter |
"+-----------+
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

let g:gitgutter_override_sign_column_highlight = 1

let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
let g:gitgutter_sign_removed_above_and_below = '吝'

highlight GitGutterAdd    ctermbg=green
highlight GitGutterChange ctermbg=blue
highlight GitGutterDelete ctermbg=red

nmap <F8> :GitGutterLineHighlightsToggle<CR>

"+-----------------+
"| MarkdownPreview |
"+-----------------+
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'chromium'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = '/home/larvasei/markdown.themes/gitbook-azure.css'

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

"+-----+
"| coc |
"+-----+
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-julia',
  \ 'coc-pyright',
  \ 'coc-tabnine',
  \ 'coc-clangd',
  \ 'coc-vimlsp',
  \ 'coc-highlight',
  \ 'coc-vimtex',
  \ 'coc-markdownlint'
  \ ]
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

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
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

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scrll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
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
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>o

autocmd CursorHold * silent call CocActionAsync('highlight')

