call plug#begin('~/.vim/plugged')
"=========================基礎設定=====================================
Plug 'kien/ctrlp.vim'                                                 | "檔案模糊搜尋
Plug 'tpope/vim-fugitive'                                             | "Git工具
Plug 'rhysd/open-pdf.vim'                                             | "PDF閱讀器
Plug 'mileszs/ack.vim'                                                | "文檔全局搜索
Plug 'junegunn/vim-emoji'                                             | "表情符號支援
Plug 'sjl/gundo.vim'                                                  | "Undo 樹
"=========================操作設定===================================== 
Plug 'christoomey/vim-tmux-navigator'                                 | "視窗間移動
Plug 'voldikss/vim-floaterm'                                          | "浮動終端
Plug 'tpope/vim-surround'                                             | "符號補全
Plug 'scrooloose/nerdcommenter'                                       | "註解快捷
Plug 'farmergreg/vim-lastplace'                                       | "最後編輯位置
"=========================外觀與狀態===================================
Plug 'scrooloose/syntastic'                                           | "語法檢查
Plug 'vim-airline/vim-airline'                                        | "狀態列
Plug 'vim-airline/vim-airline-themes'                                 | "狀態列主題
Plug 'joshdick/onedark.vim'                                           | "主題設定
Plug 'dracula/vim', { 'as': 'dracula' }                               | "主題設定
Plug 'sheerun/vim-polyglot'                                           | "圖形支援
Plug 'airblade/vim-gitgutter'                                         | "Git狀態
Plug 'APZelos/blamer.nvim'                                            | "Git修改資訊
Plug 'xuyuanp/nerdtree-git-plugin'                                    | "檔案樹Git支援
Plug 'ryanoasis/vim-devicons'                                         | "圖示支援
Plug 'scrooloose/nerdtree'                                            | "檔案樹
Plug 'luochen1990/rainbow'                                            | "彩色括弧
Plug 'yggdroot/indentline'                                            | "縮排線
Plug 'sakshamgupta05/vim-todo-highlight'                              | "Todo 高亮
Plug 'junegunn/limelight.vim'                                         | "局部高亮
Plug 'junegunn/goyo.vim'                                              | "專注模式
Plug 'mattesgroeger/vim-bookmarks'                                    | "書籤
"=========================語法設定=====================================
Plug 'plasticboy/vim-markdown'                                        | "Markdown語法高亮
Plug 'godlygeek/tabular'                                              | "Markdown語法表格
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install'} | "Markdown結果顯示
Plug 'JuliaEditorSupport/julia-vim'                                   | "Julia語法高亮
Plug 'Vimjas/vim-python-pep8-indent'                                  | "Python 縮排指南
Plug 'heavenshell/vim-pydocstring', {'do': 'make install'}            | "Python 說明文件字串支援
Plug 'elzr/vim-json'                                                  | "Json語法高亮
Plug 'neoclide/coc.nvim', {'branch': 'release'}                       | "自動補全
call plug#end()

"+---------------+
"| basic setting |
"+---------------+ 
inoremap <silent>jk <Esc>
command! W w
nnoremap <silent>qq :wqa<CR>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
set nowrap
set nu
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set relativenumber
set cursorline
set tabstop=4
set shiftwidth=4
set ai
set smartindent
set cindent
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
filetype off
set wildmenu
set wildmode=full
set scrolloff=4
let &t_ut=''
colorscheme dracula
let g:airline_theme = 'dracula'
if (has("termguicolors"))
  set termguicolors
endif
nnoremap <F4> :GundoToggle<CR>
augroup two_space_indent
      au! FileType c,cpp,markdown set tabstop=2
      au! FileType c,cpp,markdown set shiftwidth=2
augroup END
au! BufRead,VimEnter *.png,*.jpg,*jpeg exec "!feh %"

"+------------+
"| indentline |
"+------------+
let g:indentLine_enabled = 1
augroup indentline
    au VimEnter,BufRead,BufNewFile *.md,*.cpp,*.h,*.cc,*.vim exec "IndentLinesDisable"
augroup END
let g:indentLine_char_list = ['|']

"+-----------+
"| bookmarks |
"+-----------+
let g:bookmark_highlight_lines = 1
let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
	nmap ma :BookmarkShowAll<CR>
	nmap mc :BookmarkClear<CR>
    nmap mx :BookmarkClearAll<CR>
    nmap mkk :BookmarkMoveUp
    nmap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap ma
    unmap mc
    unmap mx
    unmap mkk
    unmap mjj
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()

"+-----------+
"| floatterm |
"+-----------+
let g:floaterm_autoclose = 1
let g:floaterm_height = 0.7
let g:floaterm_width = 0.75
nnoremap <silent>` :FloatermToggle<CR>
vnoremap <leader>` :FloatermSend<CR>:FloatermToggle<CR>
nnoremap <leader>` :FloatermSend<CR>:FloatermToggle<CR>

au FileType python exec "FloatermNew ipython"
au FileType julia exec "FloatermNew julia"

autocmd TermOpen * setlocal nonumber norelativenumber

tnoremap <silent>` <C-\><C-n>:FloatermToggle<CR>
tnoremap <C-j> <C-\><C-n>:TmuxNavigateDown<CR>
tnoremap <C-k> <C-\><C-n>:TmuxNavigateUp<CR>
tnoremap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
tnoremap <C-l> <C-\><C-n>:TmuxNavigateRight<CR>

"+---------+
"| rainbow |
"+---------+
let g:rainbow_active = 1

"+----------------+
"| todo-highlight |
"+----------------+
let g:todo_highlight_config = {
      \   'REVIEW': {
      \     'gui_fg_color': '#000000',
      \     'gui_bg_color': '#09ba00',
      \  },
      \   'NOTE': {
      \     'gui_fg_color': '#000000',
      \     'gui_bg_color': '#0384fc',
      \  },
      \  'TODO': {
      \  'gui_fg_color': '#000000',
      \  'gui_bg_color': '#ffbd2a',
      \  },
      \  'FIXME': {
      \  'gui_fg_color': '#000000',
      \  'gui_bg_color': '#f06292',
      \  }
      \}

"+-----+
"| ack |
"+-----+
cnoreabbrev Ack Ack!

"+----------+
"| nerdtree |
"+----------+
let NERDTreeShowHidden = 1
nmap <F2> :NERDTreeToggle<CR>

"+-----------+
"| syntastic |
"+-----------+
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_loc_list_height = 3

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

"+------------------+
"| markdown setting |
"+------------------+
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_json_frontmatter = 1
let g:goyo_width = 100
let g:goyo_height = "100%"

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
au VimEnter,BufRead,BufNewFile *.md set filetype=markdown

"+----------------+
"| python setting |
"+----------------+
let g:python3_host_prog = '/usr/bin/python3'
let g:pydocstring_formatter = 'google'
let g:syntastic_python_checkers = ['pylint', 'mypy']
nmap <leader>ss <Plug>(pydocstring)

"+---------------+
"| julia setting |
"+---------------+
let g:syntastic_julia_checkers = 1
let g:latex_to_unicode_tab = 1
let g:syntastic_julia_checkers = ['StaticLint.jl']
runtime macros/matchit.vim
inoremap <C-TAB> <C-X><C-O>
au VimEnter,BufRead,BufNewFile *.jl set filetype=julia

"+-----+
"| git |
"+-----+
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <F8> :GitGutterLineHighlightsToggle<CR>

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

let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_date_format = '%Y-%m-%d %H:%M'

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
let g:mkdp_markdown_css = '/home/larvasei/markdown.themes/obsidian.css'

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = '~/markdown.themes/styles/googlecode.css'

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
  \ 'coc-vimlsp',
  \ 'coc-highlight',
  \ 'coc-markdownlint',
  \ 'coc-emoji',
  \ 'coc-clangd',
  \ 'coc-floaterm'
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

