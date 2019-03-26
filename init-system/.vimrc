#type ~/.vimrc
set number
"set history=102400
set ruler
set autowrite
set cursorline
"设置() [] {} ''自动补齐
"inoremap ( ()<LEFT>
"inoremap [ []<LEFT>
"inoremap { {}<LEFT>
"inoremap ' ''<LEFT>
" 显示tab和空格
set list
" 设置tab和空格样式
set lcs=tab:\|\ ,nbsp:%,trail:-
" 设定行首tab为灰色
highlight LeaderTab guifg=#666666
" 匹配行首tab
match LeaderTab /^\t/
"set t_Co=256
highlight Comment ctermfg=green guifg=green
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.py,*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头  
func SetTitle()  
    "如果文件类型为.sh文件  
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash")
        call append(line("."), "\#########################################################################") 
        call append(line(".")+1, "\# File Name: ".expand("%"))  
        call append(line(".")+2, "\# Author: www.linuxea.com and mark")  
        call append(line(".")+3, "\# Email: usertzc#163.com")  
        call append(line(".")+4, "\# Version:")  
        call append(line(".")+5, "\# Created Time: ".strftime("%c"))  
        call append(line(".")+6, "\#########################################################################")  
        call append(line(".")+7, "")  
        call append(line(".")+8, "")  
    elseif &filetype == 'python'
        call setline(1,"\#!/usr/bin/env python")
        call append(line("."), "\#-*- encoding: utf-8 -*-")
        call append(line(".")+1, "\#########################################################################")
        call append(line(".")+2, "\# File Name: ".expand("%"))
        call append(line(".")+3, "\# Author: www.linuxea.com")
        call append(line(".")+4, "\# Email: usertzc#163.com")
        call append(line(".")+5, "\# Version:")
        call append(line(".")+6, "\# Created Time: ".strftime("%c"))
        call append(line(".")+7, "\#########################################################################")
        call append(line(".")+8, "")  
        call append(line(".")+9, "")    
    elseif &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>") 
        call append(line(".")+7, "using namespace std;") 
        call append(line(".")+8, "")  
    elseif &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>") 
        call append(line(".")+7, "") 
    else
        call setline(1,"/*")
        call append(line("."), "* Author: www.linuxea.com and mark")
        call append(line(".")+1, "* Created Time: ".strftime("%c"))
        call append(line(".")+2, "*/")
        call append(line(".")+3, "")
    endif 
    "新建文件后，自动定位到文件末尾 
    "autocmd BufNewFile * normal G 
endfunc 
 
"新建文件后，自动定位到文件末尾 
autocmd BufNewFile * normal G 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  
  
nmap <leader>w :w!<cr> 
nmap <leader>f :find<cr> 
  
  
" 映射全选+复制 ctrl+a  
map <C-A> ggVGY 
map! <C-A> <Esc>ggVGY 
map <F12> gg=G 
" 选中状态下 Ctrl+c 复制 
vmap <C-c> "+y 
"去空行   
nnoremap <F2> :g/^\s*$/d<CR>  
"比较文件   
nnoremap <C-F2> :vert diffsplit  
"新建标签   
map <M-F2> :tabnew<CR>   
"列出当前目录文件   
map <F3> :tabnew .<CR>   
"打开树状文件目录   
map <C-F3> \be   
"C，C++ 按F5编译运行 
map <F5> :call CompileRunGcc()<CR> 
func! CompileRunGcc() 
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./% 
    endif 
endfunc 
"C,C++的调试 
map <F8> :call Rungdb()<CR> 
func! Rungdb() 
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc 
set tabstop=4
"set expandtab
"set guioptions+=b
set shortmess=atI
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif
map <F3> :tabnew .<CR>
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\[%p%%]
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%y-%m-%d\ -\ %H:%M:%S\")}
set laststatus=2
