let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +48 ~/.config/nvim/lua/polish.lua
badd +32 ~/.config/nvim/lua/plugins/user.lua
badd +1 ~/.config/nvim/lua/user/session.lua
badd +1 ~/.config/nvim/lua/plugins/astrolsp.lua
badd +2 ~/.config/nvim/.gitignore
badd +18 ~/.config/nvim/init.lua
badd +1 ~/.config/nvim/init.sh
badd +1 ~/.config/nvim/neovim.yml
badd +27 ~/.config/nvim/lua/plugins/auto-save.lua
badd +1 ~/.config/nvim/lua/plugins/avante.lua
badd +80 ~/.config/nvim/lua/plugins/barbar.lua
badd +1 ~/.config/nvim/lua/plugins/catppuccin.lua
badd +1 ~/.config/nvim/lua/plugins/cmp_ai.lua
badd +1 ~/.config/nvim/lua/plugins/copilot.lua
badd +40 ~/.config/nvim/lua/plugins/copilot_chat.lua
badd +11 ~/.config/nvim/lua/plugins/fugitive.lua
badd +1 ~/.config/nvim/lua/plugins/neo-tree.lua
badd +1 ~/.config/nvim/lua/plugins/telescope.lua
badd +1 ~/.config/nvim/lua/plugins/treesitter.lua
badd +1 ~/.config/nvim/lua/plugins/mouse_hover.lua
badd +93 ~/.config/nvim/lua/plugins/lualine.lua
badd +1 ~/.config/nvim/lua/plugins/mason.lua
badd +176 ~/.config/nvim/lua/plugins/dap.lua
badd +53 ~/.config/nvim/lua/plugins/gitsigns.lua
argglobal
%argdel
argglobal
enew
file neo-tree\ filesystem\ \[1]
balt ~/.config/nvim/lua/plugins/auto-save.lua
setlocal foldmethod=expr
setlocal foldexpr=v:lua.require'astroui.folding'.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :

" Last focused file: /home/raka/.config/nvim/.gitignore
let g:last_focused_file = "/home/raka/.config/nvim/.gitignore"
