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
nnoremap  w <Cmd>w
nnoremap  Q <Cmd>confirm qall
nnoremap  n <Cmd>enew
nmap  / gcc
nnoremap  q <Cmd>confirm q
nnoremap  xq <Cmd>copen
nnoremap  xl <Cmd>lopen
nnoremap  pM <Cmd>MasonToolsUpdate
nnoremap  e <Cmd>Neotree toggle
nnoremap  tf <Cmd>ToggleTerm direction=float
nnoremap  th <Cmd>ToggleTerm size=10 direction=horizontal
nnoremap  tv <Cmd>ToggleTerm size=80 direction=vertical
nnoremap  fT <Cmd>TodoTelescope
xmap  / gc
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
nnoremap <silent> <expr> j v:count == 0 ? 'gj' : 'j'
xnoremap <silent> <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <silent> <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap <silent> <expr> k v:count == 0 ? 'gk' : 'k'
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
nnoremap <silent> <F6> <Cmd>call SaveSessionWithNotify()
nnoremap <silent> <F7> <Cmd>call RestoreSessionWithNotify()
nnoremap <C-'> <Cmd>execute v:count . "ToggleTerm"
nnoremap <C-S> <Cmd>silent! update! | redraw
nnoremap <C-Q> <Cmd>q!
tnoremap <F7> <Cmd>ToggleTerm
tnoremap <C-'> <Cmd>ToggleTerm
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
set eventignore=all
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
set runtimepath=~/.config/nvim,~/.local/share/nvim/lazy/lazy.nvim,~/.local/share/nvim/lazy/neo-tree.nvim,~/.local/share/nvim/lazy/mason-tool-installer.nvim,~/.local/share/nvim/lazy/lsp_signature.nvim,~/.local/share/nvim/lazy/lazydev.nvim,~/.local/share/nvim/lazy/friendly-snippets,~/.local/share/nvim/lazy/LuaSnip,~/.local/share/nvim/lazy/blink.cmp,~/.local/share/nvim/lazy/astrolsp,~/.local/share/nvim/lazy/nvim-lsp-file-operations,~/.local/share/nvim/lazy/aerial.nvim,~/.local/share/nvim/lazy/mason-null-ls.nvim,~/.local/share/nvim/lazy/none-ls.nvim,~/.local/share/nvim/lazy/vim-illuminate,~/.local/share/nvim/lazy/nvim-highlight-colors,~/.local/share/nvim/lazy/nvim-ts-autotag,~/.local/share/nvim/lazy/mason-lspconfig.nvim,~/.local/share/nvim/lazy/neoconf.nvim,~/.local/share/nvim/lazy/nvim-lspconfig,~/.local/share/nvim/lazy/nvim-autopairs,~/.local/share/nvim/lazy/todo-comments.nvim,~/.local/share/nvim/lazy/resession.nvim,~/.local/share/nvim/lazy/schemastore.nvim,~/.local/share/nvim/lazy/smart-splits.nvim,~/.local/share/nvim/lazy/guess-indent.nvim,~/.local/share/nvim/lazy/gopher.nvim,~/.local/share/nvim/lazy/blink.compat,~/.local/share/nvim/lazy/cmp-dap,~/.local/share/nvim/lazy/nvim-nio,~/.local/share/nvim/lazy/nvim-dap-ui,~/.local/share/nvim/lazy/mason-nvim-dap.nvim,~/.local/share/nvim/lazy/nvim-dap,~/.local/share/nvim/lazy/nvim-dap-go,~/.local/share/nvim/lazy/nui.nvim,~/.local/share/nvim/lazy/lualine.nvim,~/.local/share/nvim/lazy/plenary.nvim,~/.local/share/nvim/lazy/copilot.lua,~/.local/share/nvim/lazy/CopilotChat.nvim,~/.local/share/nvim/lazy/mason.nvim,~/.local/share/nvim/lazy/nvim-treesitter-textobjects,~/.local/share/nvim/lazy/nvim-treesitter,~/.local/share/nvim/lazy/copilot.vim,~/.local/share/nvim/lazy/better-escape.nvim,~/.local/share/nvim/lazy/heirline.nvim,~/.local/share/nvim/lazy/which-key.nvim,~/.local/share/nvim/lazy/hover.nvim,~/.local/share/nvim/lazy/presence.nvim,~/.local/share/nvim/lazy/satellite.nvim,~/.local/share/nvim/lazy/mini.icons,~/.local/share/nvim/lazy/nvim-web-devicons,~/.local/share/nvim/lazy/gitsigns.nvim,~/.local/share/nvim/lazy/barbar.nvim,~/.local/share/nvim/lazy/snacks.nvim,~/.local/share/nvim/lazy/catppuccin,~/.local/share/nvim/lazy/AstroNvim,~/.local/share/nvim/lazy/astrotheme,~/.local/share/nvim/lazy/astrocommunity,~/.local/share/nvim/lazy/astroui,~/.local/share/nvim/lazy/astrocore,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.11.3/share/nvim/runtime,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.11.3/share/nvim/runtime/pack/dist/opt/matchit,/home/linuxbrew/.linuxbrew/Cellar/neovim/0.11.3/lib/nvim,~/.local/state/nvim/lazy/readme,~/.local/share/nvim/lazy/cmp-dap/after,~/.local/share/nvim/lazy/catppuccin/after
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,options
set shadafile=~/.config/nvim/shada/workspaces/2055e56ab5a8b34bd8e69ce3fdfea1d89c1a5c8a879d242a9136191dcdb1dbb7/shada
set shiftround
set shiftwidth=0
set shortmess=lsFtocCIOT
set noshowmode
set showtabline=2
set smartcase
set splitbelow
set splitright
set statusline=%#lualine_transparent#
set tabclose=uselast
set tabline=%4@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ \ %#BufferInactive#󰟓\ %4@barbar#events#main_click_handler@%#BufferInactive#main.go%#BufferInactive#\ \ \ \ %4@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %4@barbar#events#main_click_handler@%#BufferInactiveSignRight#%5@barbar#events#main_click_handler@%#BufferInactiveSign#▎%#BufferInactive#\ \ \ \ %#BufferInactive#\ %5@barbar#events#main_click_handler@%#BufferInactive#docker-compose.yml%#BufferInactive#\ \ \ \ %5@barbar#events#close_click_handler@%#BufferInactiveBtn#\ %5@barbar#events#main_click_handler@%#BufferInactiveSignRight#%6@barbar#events#main_click_handler@%#BufferCurrentSign#▎%#BufferCurrent#\ \ \ \ %#MiniIconsBlueCurrent#󰡨\ %6@barbar#events#main_click_handler@%#BufferCurrent#Dockerfile%#BufferCurrent#\ \ \ \ %6@barbar#events#close_click_handler@%#BufferCurrentBtn#\ %6@barbar#events#main_click_handler@%#BufferCurrentSignRight#%#BufferInactiveSign#▎%#BufferTabpageFill#\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ %0@barbar#events#main_click_handler@%#BufferTabpageFill#
set tabstop=2
set termguicolors
set timeoutlen=500
set title
set undofile
set updatetime=100
set virtualedit=block
set window=49
set nowritebackup
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd /mnt/zig/code/golang/puma/ninja-combined-crawler
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 /mnt/zig/code/golang/puma/ninja-combined-crawler/main.go
badd +1 /mnt/zig/code/golang/puma/ninja-combined-crawler/docker-compose.yml
badd +1 /mnt/zig/code/golang/puma/ninja-combined-crawler/Dockerfile
argglobal
%argdel
edit /mnt/zig/code/golang/puma/ninja-combined-crawler/Dockerfile
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt /mnt/zig/code/golang/puma/ninja-combined-crawler/main.go
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <M-e> l<Cmd>lua require('nvim-autopairs.fastwrap').show()
xnoremap <buffer> ih :Gitsigns select_hunk
onoremap <buffer> ih :Gitsigns select_hunk
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
setlocal comments=:#
setlocal commentstring=#\ %s
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
setlocal nodiff
setlocal eventignorewin=
setlocal expandtab
if &filetype != 'dockerfile'
setlocal filetype=dockerfile
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
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=v:lua.vim.lsp.omnifunc
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
setlocal shiftwidth=4
set signcolumn=yes
setlocal signcolumn=yes
setlocal nosmartindent
setlocal nosmoothscroll
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\\t\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=noplainbuffer
set statuscolumn=%{%v:lua.require'heirline'.eval_statuscolumn()%}
setlocal statuscolumn=%{%v:lua.require'heirline'.eval_statuscolumn()%}
setlocal statusline=%#lualine_a_normal#\ N\ %#lualine_b_normal#\ \ LZ-821\ %<%#lualine_c_normal#\ Dockerfile\ %#lualine_c_normal#%=%#lualine_x_9_normal#\ \ TS\ %#lualine_c_normal#%#lualine_c_normal#\ utf-8\ %#lualine_c_normal#\ \ %#lualine_x_filetype_MiniIconsBlue_normal#\ 󰡨\ %#lualine_c_normal#dockerfile\ %#lualine_b_normal#\ Top\ %#lualine_a_normal#\ \ \ 1:34\ 
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=4
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
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 034|
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
set shortmess=lsFtocCIOT
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

" Last focused file: /mnt/zig/code/golang/puma/ninja-combined-crawler/Dockerfile
let g:last_focused_file = "/mnt/zig/code/golang/puma/ninja-combined-crawler/Dockerfile"
