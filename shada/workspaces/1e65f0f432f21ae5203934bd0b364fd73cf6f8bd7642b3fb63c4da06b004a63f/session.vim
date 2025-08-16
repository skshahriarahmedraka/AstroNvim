let SessionLoad = 1
let s:cpo_save=&cpo
set cpo&vim
imap <M-C-Right> <Plug>(copilot-accept-line)
imap <M-Right> <Plug>(copilot-accept-word)
imap <M-Bslash> <Plug>(copilot-suggest)
imap <M-[> <Plug>(copilot-previous)
imap <M-]> <Plug>(copilot-next)
imap <Plug>(copilot-suggest) <Cmd>call copilot#Suggest()
imap <Plug>(copilot-previous) <Cmd>call copilot#Previous()
imap <Plug>(copilot-next) <Cmd>call copilot#Next()
imap <Plug>(copilot-dismiss) <Cmd>call copilot#Dismiss()
inoremap <F7> <Cmd>ToggleTerm
inoremap <C-'> <Cmd>ToggleTerm
inoremap <C-W> u
inoremap <C-U> u
vnoremap 	 >gv
nnoremap  <Cmd>q!
nnoremap  <Cmd>silent! update! | redraw
nmap  d
nnoremap  ccD <Cmd>CopilotChatFixDiagnostic
vnoremap  cct <Cmd>CopilotChatTests
nnoremap  cct <Cmd>CopilotChatTests
vnoremap  ccd <Cmd>CopilotChatDocs
nnoremap  ccd <Cmd>CopilotChatDocs
vnoremap  cco <Cmd>CopilotChatOptimize
nnoremap  cco <Cmd>CopilotChatOptimize
vnoremap  ccf <Cmd>CopilotChatFix
nnoremap  ccf <Cmd>CopilotChatFix
vnoremap  ccr <Cmd>CopilotChatReview
nnoremap  ccr <Cmd>CopilotChatReview
vnoremap  cce <Cmd>CopilotChatExplain
nnoremap  cce <Cmd>CopilotChatExplain
nnoremap  ccl <Cmd>CopilotChatLoad
nnoremap  ccs <Cmd>CopilotChatSave
nnoremap  ccx <Cmd>CopilotChatReset
nnoremap  ccq <Cmd>CopilotChatToggle
xnoremap  ccV :CopilotChatInPlace
xnoremap  ccv :CopilotChatVisual
vnoremap  ccR <Cmd>CopilotChatRefactorAgent
nnoremap  ccR <Cmd>CopilotChatRefactorAgent
vnoremap  ccb <Cmd>CopilotChatDebugAgent
nnoremap  ccb <Cmd>CopilotChatDebugAgent
vnoremap  ccA <Cmd>CopilotChatCodeAgent
nnoremap  ccA <Cmd>CopilotChatCodeAgent
vnoremap  cca <Cmd>CopilotChatAgent
nnoremap  cca <Cmd>CopilotChatAgent
nnoremap  ccM <Cmd>CopilotChatCommitStaged
nnoremap  ccm <Cmd>CopilotChatCommit
vnoremap  ccD <Cmd>CopilotChatFixDiagnostic
xmap  / gc
nnoremap  fT <Cmd>TodoTelescope
nnoremap  pM <Cmd>MasonToolsUpdate
nnoremap  Q <Cmd>confirm qall
nnoremap  q <Cmd>confirm q
nnoremap  e <Cmd>Neotree toggle
nnoremap  w <Cmd>w
nnoremap  n <Cmd>enew
nnoremap  xq <Cmd>copen
nnoremap  xl <Cmd>lopen
nmap  / gcc
nnoremap  tf <Cmd>ToggleTerm direction=float
nnoremap  th <Cmd>ToggleTerm size=10 direction=horizontal
nnoremap  tv <Cmd>ToggleTerm size=80 direction=vertical
omap <silent> % <Plug>(MatchitOperationForward)
xmap <silent> % <Plug>(MatchitVisualForward)
nmap <silent> % <Plug>(MatchitNormalForward)
nnoremap & :&&
xnoremap <silent> <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'' : '@'
xnoremap <silent> <expr> Q mode() ==# 'V' ? ':normal! @=reg_recorded()' : 'Q'
nnoremap Y y$
omap <silent> [% <Plug>(MatchitOperationMultiBackward)
xmap <silent> [% <Plug>(MatchitVisualMultiBackward)
nmap <silent> [% <Plug>(MatchitNormalMultiBackward)
nnoremap \ <Cmd>split
omap <silent> ]% <Plug>(MatchitOperationMultiForward)
xmap <silent> ]% <Plug>(MatchitVisualMultiForward)
nmap <silent> ]% <Plug>(MatchitNormalMultiForward)
xmap a% <Plug>(MatchitVisualTextObject)
omap <silent> g% <Plug>(MatchitOperationBackward)
xmap <silent> g% <Plug>(MatchitVisualBackward)
nmap <silent> g% <Plug>(MatchitNormalBackward)
nnoremap gco oVcx<Cmd>normal gccfxa<BS>
nnoremap gcO OVcx<Cmd>normal gccfxa<BS>
xnoremap <silent> <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <silent> <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <silent> <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <silent> <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap | <Cmd>vsplit
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_file(vim.fn.expand("%:p"))
xmap <silent> <Plug>(MatchitVisualTextObject) <Plug>(MatchitVisualMultiBackward)o<Plug>(MatchitVisualMultiForward)
onoremap <silent> <Plug>(MatchitOperationMultiForward) :call matchit#MultiMatch("W",  "o")
onoremap <silent> <Plug>(MatchitOperationMultiBackward) :call matchit#MultiMatch("bW", "o")
xnoremap <silent> <Plug>(MatchitVisualMultiForward) :call matchit#MultiMatch("W",  "n")m'gv``
xnoremap <silent> <Plug>(MatchitVisualMultiBackward) :call matchit#MultiMatch("bW", "n")m'gv``
nnoremap <silent> <Plug>(MatchitNormalMultiForward) :call matchit#MultiMatch("W",  "n")
nnoremap <silent> <Plug>(MatchitNormalMultiBackward) :call matchit#MultiMatch("bW", "n")
onoremap <silent> <Plug>(MatchitOperationBackward) :call matchit#Match_wrapper('',0,'o')
onoremap <silent> <Plug>(MatchitOperationForward) :call matchit#Match_wrapper('',1,'o')
xnoremap <silent> <Plug>(MatchitVisualBackward) :call matchit#Match_wrapper('',0,'v')m'gv``
xnoremap <silent> <Plug>(MatchitVisualForward) :call matchit#Match_wrapper('',1,'v'):if col("''") != col("$") | exe ":normal! m'" | endifgv``
nnoremap <silent> <Plug>(MatchitNormalBackward) :call matchit#Match_wrapper('',0,'n')
nnoremap <silent> <Plug>(MatchitNormalForward) :call matchit#Match_wrapper('',1,'n')
nnoremap <C-'> <Cmd>execute v:count . "ToggleTerm"
nnoremap <C-Q> <Cmd>q!
nnoremap <silent> <F7> <Cmd>call RestoreSessionWithNotify()
nnoremap <C-S> <Cmd>silent! update! | redraw
nnoremap <silent> <F6> <Cmd>call SaveSessionWithNotify()
tnoremap <C-'> <Cmd>ToggleTerm
tnoremap <F7> <Cmd>ToggleTerm
nmap <C-W><C-D> d
vnoremap <S-Tab> <gv
inoremap <expr>  v:lua.require'nvim-autopairs'.completion_confirm()
inoremap  u
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set backspace=indent,eol,start,nostop
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect
set confirm
set copyindent
set diffopt=internal,filler,closeoff,linematch:40,algorithm:histogram,linematch:60
set expandtab
set fillchars=eob:\ 
set grepformat=%f:%l:%c:%m
set grepprg=rg\ --vimgrep\ -uu\ 
set helplang=en
set nohlsearch
set ignorecase
set infercase
set jumpoptions=
set noloadplugins
set mouse=a
set mousemoveevent
set packpath=/home/linuxbrew/.linuxbrew/Cellar/neovim/0.11.3/share/nvim/runtime
set preserveindent
set pumheight=10
set runtimepath=~/.config/nvim,~/.local/share/nvim/lazy/lazy.nvim,~/.local/share/nvim/lazy/astrolsp,~/.local/share/nvim/lazy/nvim-lsp-file-operations,~/.local/share/nvim/lazy/neo-tree.nvim,~/.local/share/nvim/lazy/mason-null-ls.nvim,~/.local/share/nvim/lazy/none-ls.nvim,~/.local/share/nvim/lazy/todo-comments.nvim,~/.local/share/nvim/lazy/nvim-ts-autotag,~/.local/share/nvim/lazy/nvim-highlight-colors,~/.local/share/nvim/lazy/mason-lspconfig.nvim,~/.local/share/nvim/lazy/neoconf.nvim,~/.local/share/nvim/lazy/nvim-lspconfig,~/.local/share/nvim/lazy/nvim-autopairs,~/.local/share/nvim/lazy/vim-illuminate,~/.local/share/nvim/lazy/aerial.nvim,~/.local/share/nvim/lazy/mason-tool-installer.nvim,~/.local/share/nvim/lazy/lazydev.nvim,~/.local/share/nvim/lazy/lsp_signature.nvim,~/.local/share/nvim/lazy/resession.nvim,~/.local/share/nvim/lazy/friendly-snippets,~/.local/share/nvim/lazy/LuaSnip,~/.local/share/nvim/lazy/smart-splits.nvim,~/.local/share/nvim/lazy/nui.nvim,~/.local/share/nvim/lazy/blink.cmp,~/.local/share/nvim/lazy/guess-indent.nvim,~/.local/share/nvim/lazy/lualine.nvim,~/.local/share/nvim/lazy/mason.nvim,~/.local/share/nvim/lazy/nvim-treesitter-textobjects,~/.local/share/nvim/lazy/nvim-treesitter,~/.local/share/nvim/lazy/copilot.vim,~/.local/share/nvim/lazy/better-escape.nvim,~/.local/share/nvim/lazy/plenary.nvim,~/.local/share/nvim/lazy/copilot.lua,~/.local/share/nvim/lazy/CopilotChat.nvim,~/.local/share/nvim/lazy/heirline.nvim,~/.local/share/nvim/lazy/which-key.nvim,~/.local/share/nvim/lazy/mini.icons,~/.local/share/nvim/lazy/nvim-web-devicons,~/.local/share/nvim/lazy/gitsigns.nvim,~/.local/share/nvim/lazy/barbar.nvim,~/.local/share/nvim/lazy/presence.nvim,~/.local/share/nvim/lazy/hover.nvim,~/.local/share/nvim/lazy/satellite.nvim,~/.local/share/nvim/lazy/snacks.nvim,~/.local/share/nvim/lazy/catppuccin,~/.local/share/nvim/lazy/AstroNvim,~/.local/share/nvim/lazy/astrotheme,~/.local/share/nvim/lazy/astrocommunity,~/.local/share/nvim/lazy/astroui,~/.local/share/nvim/lazy/astrocore,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.11.3/share/nvim/runtime,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.11.3/share/nvim/runtime/pack/dist/opt/matchit,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.11.3/lib/nvim,~/.local/state/nvim/lazy/readme,~/.local/share/nvim/lazy/catppuccin/after
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,options
set shadafile=~/.config/nvim/shada/workspaces/1e65f0f432f21ae5203934bd0b364fd73cf6f8bd7642b3fb63c4da06b004a63f/shada
set shiftround
set shiftwidth=0
set shortmess=oOcTsIltCF
set noshowmode
set showtabline=0
set smartcase
set splitbelow
set splitright
set statusline=%#lualine_transparent#
set tabclose=uselast
set tabline=%4@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ %#BufferInactive#󰢱\ %4@barbar#events#main_click_handler@%#BufferInactive#session.lua%#BufferInactive#\ \ \ %4@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %4@barbar#events#main_click_handler@%#BufferInactiveSignRight#%5@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ %#BufferInactive#󰢱\ %5@barbar#events#main_click_handler@%#BufferInactive#community.lua%#BufferInactive#\ \ \ %5@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %5@barbar#events#main_click_handler@%#BufferInactiveSignRight#%18@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ %#BufferInactive#\ %18@barbar#events#main_click_handler@%#BufferInactive#user/init.lua%#BufferInactive#\ \ \ %18@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %18@barbar#events#main_click_handler@%#BufferInactiveSignRight#%6@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ %#BufferInactive#\ %6@barbar#events#main_click_handler@%#BufferInactive#nvim/init.lua%#BufferInactive#\ \ \ %6@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %6@barbar#events#main_click_handler@%#BufferInactiveSignRight#%7@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ %#BufferInactive#󰢱\ %7@barbar#events#main_click_handler@%#BufferInactive#lazy_setup.lua%#BufferInactive#\ \ \ %7@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %7@barbar#events#main_click_handler@%#BufferInactiveSignRight#%8@barbar#events#main_click_handler@%#BufferCurrentSign#▎%#BufferCurrent#\ \ \ %#MiniIconsAzureCurrent#󰢱\ %8@barbar#events#main_click_handler@%#BufferCurrent#polish.lua%#BufferCurrent#\ \ \ %8@barbar#events#close_click_handler@%#BufferCurrentBtn#\ %8@barbar#events#main_click_handler@%#BufferCurrentSignRight#%9@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ %#BufferInactive#󰢱\ %9@barbar#events#main_click_handler@%#BufferInactive#barbar.lua%#BufferInactive#\ \ \ %9@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %9@barbar#events#main_click_handler@%#BufferInactiveSignRight#%10@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ %#BufferInactive#󰢱\ %10@barbar#events#main_click_handler@%#BufferInactive#gitsigns.lua%#BufferInactive#\ \ \ %10@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %10@barbar#events#main_click_handler@%#BufferInactiveSignRight#%#BufferInactiveSign#▎%#BufferTabpageFill#\ \ \ \ \ \ %0@barbar#events#main_click_handler@%#BufferTabpageFill#
set tabstop=2
set termguicolors
set timeoutlen=500
set title
set undofile
set updatetime=250
set virtualedit=block
set window=49
set nowritebackup
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/.config/nvim/lua/user/session.lua
badd +36 ~/.config/nvim/lua/community.lua
badd +19 ~/.config/nvim/init.lua
badd +13 ~/.config/nvim/lua/lazy_setup.lua
badd +73 ~/.config/nvim/lua/polish.lua
badd +1 ~/.config/nvim/lua/plugins/barbar.lua
badd +53 ~/.config/nvim/lua/plugins/gitsigns.lua
badd +9 ~/.config/nvim/lua/user/init.lua
argglobal
%argdel
edit ~/.config/nvim/lua/polish.lua
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
enew
file neo-tree\ filesystem\ \[1]
balt ~/.config/nvim/lua/polish.lua
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=hide
setlocal nobuflisted
setlocal buftype=nofile
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,fb:���
setlocal commentstring=
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeslash=
setlocal concealcursor=
setlocal conceallevel=0
setlocal copyindent
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal cursorlineopt=line
setlocal nodiff
setlocal eventignorewin=
setlocal expandtab
if &filetype != 'neo-tree'
setlocal filetype=neo-tree
endif
setlocal fixendofline
set foldcolumn=1
setlocal foldcolumn=0
setlocal foldenable
set foldexpr=v:lua.require'astroui.folding'.foldexpr()
setlocal foldexpr=v:lua.require'astroui.folding'.foldexpr()
setlocal foldignore=#
set foldlevel=99
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
set foldmethod=expr
setlocal foldmethod=expr
setlocal foldminlines=1
setlocal foldnestmax=20
set foldtext=
setlocal foldtext=
setlocal formatexpr=
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=tcqj
setlocal iminsert=0
setlocal imsearch=-1
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal infercase
setlocal iskeyword=@,48-57,_,192-255
set linebreak
setlocal linebreak
setlocal nolisp
setlocal lispoptions=
setlocal nolist
setlocal matchpairs=(:),{:},[:]
setlocal nomodeline
setlocal nomodifiable
setlocal nrformats=bin,hex
set number
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal preserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal readonly
set relativenumber
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal scrollback=-1
setlocal noscrollbind
setlocal shiftwidth=0
set signcolumn=yes
setlocal signcolumn=auto
setlocal nosmartindent
setlocal nosmoothscroll
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\\t\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
set statuscolumn=%{%v:lua.require'heirline'.eval_statuscolumn()%}
setlocal statuscolumn=%{%v:lua.require'heirline'.eval_statuscolumn()%}
setlocal statusline=%#lualine_a_inactive#\ ~/.config/nvim\ %#lualine_c_inactive#%=
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'neo-tree'
setlocal syntax=neo-tree
endif
setlocal tabstop=2
setlocal tagfunc=
setlocal textwidth=0
setlocal undofile
setlocal undolevels=0
setlocal varsofttabstop=
setlocal vartabstop=
setlocal winbar=%{%v:lua.require'neo-tree.ui.selector'.get()%}
setlocal winblend=0
setlocal nowinfixbuf
setlocal winfixheight
setlocal winfixwidth
setlocal winhighlight=Normal:NeoTreeNormal,NormalNC:NeoTreeNormalNC,SignColumn:NeoTreeSignColumn,CursorLine:NeoTreeCursorLine,FloatBorder:NeoTreeFloatBorder,StatusLine:NeoTreeStatusLine,StatusLineNC:NeoTreeStatusLineNC,VertSplit:NeoTreeVertSplit,EndOfBuffer:NeoTreeEndOfBuffer,WinSeparator:NeoTreeWinSeparator
set nowrap
setlocal nowrap
setlocal wrapmargin=0
wincmd w
argglobal
balt ~/.config/nvim/lua/user/init.lua
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <M-e> l<Cmd>lua require('nvim-autopairs.fastwrap').show()
nnoremap <buffer>  bb <C-6>
nnoremap <buffer>  lI <Cmd>NullLsInfo
nnoremap <buffer>  li <Cmd>LspInfo
xnoremap <buffer> <silent> ao <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@loop.outer','textobjects','x')
onoremap <buffer> <silent> ao <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@loop.outer','textobjects','o')
xnoremap <buffer> <silent> ak <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@block.outer','textobjects','x')
onoremap <buffer> <silent> ak <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@block.outer','textobjects','o')
xnoremap <buffer> <silent> aa <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@parameter.outer','textobjects','x')
onoremap <buffer> <silent> aa <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@parameter.outer','textobjects','o')
xnoremap <buffer> <silent> a? <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@conditional.outer','textobjects','x')
onoremap <buffer> <silent> a? <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@conditional.outer','textobjects','o')
xnoremap <buffer> <silent> af <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.outer','textobjects','x')
onoremap <buffer> <silent> af <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.outer','textobjects','o')
xnoremap <buffer> <silent> ik <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@block.inner','textobjects','x')
onoremap <buffer> <silent> ik <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@block.inner','textobjects','o')
xnoremap <buffer> <silent> io <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@loop.inner','textobjects','x')
onoremap <buffer> <silent> io <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@loop.inner','textobjects','o')
xnoremap <buffer> <silent> ia <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@parameter.inner','textobjects','x')
onoremap <buffer> <silent> ia <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@parameter.inner','textobjects','o')
xnoremap <buffer> <silent> i? <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@conditional.inner','textobjects','x')
onoremap <buffer> <silent> i? <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@conditional.inner','textobjects','o')
xnoremap <buffer> <silent> if <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.inner','textobjects','x')
onoremap <buffer> <silent> if <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.inner','textobjects','o')
onoremap <buffer> ih :Gitsigns select_hunk
xnoremap <buffer> ih :Gitsigns select_hunk
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal nobinary
set breakindent
setlocal breakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:---,:--
setlocal commentstring=--\ %s
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeslash=
setlocal concealcursor=
setlocal conceallevel=0
setlocal copyindent
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal cursorlineopt=both
setlocal define=\\<function\\|\\<local\\%(\\s\\+function\\)\\=
setlocal nodiff
setlocal eventignorewin=
setlocal expandtab
if &filetype != 'lua'
setlocal filetype=lua
endif
setlocal fixendofline
set foldcolumn=1
setlocal foldcolumn=1
setlocal foldenable
set foldexpr=v:lua.require'astroui.folding'.foldexpr()
setlocal foldexpr=v:lua.require'astroui.folding'.foldexpr()
setlocal foldignore=#
set foldlevel=99
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
set foldmethod=expr
setlocal foldmethod=expr
setlocal foldminlines=1
setlocal foldnestmax=20
set foldtext=
setlocal foldtext=
setlocal formatexpr=v:lua.vim.lsp.formatexpr()
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=jcroql
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=\\<\\%(\\%(do\\|load\\)file\\|require\\)\\s*(
setlocal includeexpr=v:lua.require'vim._ftplugin.lua'.includeexpr(v:fname)
setlocal indentexpr=nvim_treesitter#indent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,0=end,0=until
setlocal infercase
setlocal iskeyword=@,48-57,_,192-255
set linebreak
setlocal linebreak
setlocal nolisp
setlocal lispoptions=
setlocal nolist
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=v:lua.vim.lsp.omnifunc
setlocal path=,
setlocal preserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
set relativenumber
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal scrollback=-1
setlocal noscrollbind
setlocal shiftwidth=2
set signcolumn=yes
setlocal signcolumn=yes
setlocal nosmartindent
setlocal nosmoothscroll
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\\t\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=noplainbuffer
set statuscolumn=%{%v:lua.require'heirline'.eval_statuscolumn()%}
setlocal statuscolumn=%{%v:lua.require'heirline'.eval_statuscolumn()%}
setlocal statusline=%#lualine_a_normal#\ N\ %#lualine_b_normal#\ \ master\ %#lualine_b_diff_added_normal#\ \ 5\ %<%#lualine_c_normal#\ lua/polish.lua\ %#lualine_c_diagnostics_warn_normal#\ \ 1\ %#lualine_c_normal#%=%#lualine_x_6_normal#\ \ GitHub\ Copilot,\ lua_ls\ %#lualine_c_normal#%#lualine_x_7_normal#\ \ TS\ %#lualine_c_normal#%#lualine_c_normal#\ utf-8\ %#lualine_c_normal#\ \ %#lualine_x_filetype_MiniIconsAzure_normal#\ 󰢱\ %#lualine_c_normal#lua\ %#lualine_b_normal#\ Bot\ %#lualine_a_normal#\ \ 73:1\ \ 
setlocal suffixesadd=.lua
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=2
setlocal tagfunc=v:lua.vim.lsp.tagfunc
setlocal textwidth=0
setlocal undofile
setlocal varsofttabstop=
setlocal vartabstop=
setlocal winbar=%{%v:lua.require'heirline'.eval_winbar()%}
setlocal winblend=0
setlocal nowinfixbuf
setlocal winfixheight
setlocal winfixwidth
setlocal winhighlight=
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 73 - ((45 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 73
normal! 0
wincmd w
2wincmd w
wincmd =
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
set shortmess=oOcTsIltCF
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :

" Last focused file: /home/raka/.config/nvim/lua/polish.lua
let g:last_focused_file = "/home/raka/.config/nvim/lua/polish.lua"
