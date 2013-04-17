set bk
"let $LANG='en'
set nocompatible

" Pathogen {{{
"filetype off

"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

"filetype plugin indent on

"}}}

" CLANG {{{
"let g:clang_complete_copen = 1
"let g:clang_user_options = '-IC:\foo\bar "-IC:\path with spaces\keke" 2> NUL || exit 0"'
let g:clang_use_library = 1
let g:clang_lbrary_path = 'C:/lang/llvm/bin/'
"}}}

" Template {{{
let g:template_basedir=expand('$HOME') . '/.vim/'
"}}}

" Vundle {{{
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...
Bundle 'Rip-Rip/clang_complete'
Bundle 'syntaxhaskell.vim'
Bundle 'haskell-mode'
"Bundle 'Superior-Haskell-Interaction-Mode-SHIM'
Bundle 'bitc/lushtags'
Bundle 'TabBar'
Bundle 'TagBar'
Bundle 'taglist.vim'
Bundle 'xolox/vim-shell'
"Bundle 'vimsh.tar.gz'
nmap <Leader>sh :call OpenVimShell() <cr>
Bundle 'Conque-Shell'
Bundle 'template.vim'
Bundle 'FSwitch'
filetype plugin indent on     " required!
syntax on

"}}}

function OpenVimShell() " {{{
          source ~/.vim/bundle/vimsh.tar.gz/plugin/vimsh.vim
	  :call VimShellSettings()
endfunction "}}}

function VimShellSettings() "{{{
	  :set encoding=cp866	
endfunction "}}}

" Win settings {{{
source $VIMRUNTIME/mswin.vim
source $VIMRUNTIME/gvimrc_example.vim
behave mswin
" }}}

" TO Html {{{
" :TOhtml
"set diffopt=filler,context:8:iwhite

let g:html_dynamic_folds=1

let g:html_number_lines = 1

" }}}

" Vim fswitch {{{

augroup fswitch-autocommands
    au BufEnter *.cpp let b:fswitchdst  = 'h,hpp'
    au BufEnter *.cpp let b:fswitchlocs = './,./include/,../include,./inc'

    au BufEnter *.h let b:fswitchdst  = 'c,cpp'
    au BufEnter *.h let b:fswitchlocs = '../src,../,./'
augroup END

function! ToggleFTContextMenu(languages, modifiers, menuitem, action)
    for lang_ in a:languages
        if &filetype != lang_
            execute 'silent! aunmenu ' . a:menuitem
            continue
        endif
        for modifier in a:modifiers
            let esc = ''
            if modifier == 'i'
                let esc = '<esc>'
            endif
            let command =  modifier . 'menu <silent> ' . a:menuitem . ' ' . esc .':call ' . a:action . '<cr>'
            execute command
        endfor
        return
    endfor
endfunction

augroup user-contextmenu
    au MenuPopup * call ToggleFTContextMenu(["cpp", "c"],["i","n"],
                \"PopUp.-Usrsep5-", ":")

    au MenuPopup * call ToggleFTContextMenu(["cpp", "c"],["i","n"],
                \"PopUp.Swtich\\ Header/Source", "FSwitch('%', '')")
augroup END

" }}}

" Template Plugin{{{

augroup template-plugin
    autocmd User plugin-template-loaded call s:template_keywords()
augroup END

function! s:template_keywords()
	
	if search('<+FILE_NAME+>')
		silent %s/<+FILE_NAME+>/\=toupper(expand('%:t:r'))/g
	endif
	
	if search('<+FileName+>')
		silent %s/<+FileName+>/\=expand('%:t:r')/g
	endif
	
	if search('<+Header+>')
		let header = expand('%:t:r') . ".h"
		silent %s/<+Header+>/\=header/g
	endif
	
	if search('<+Class+>')
		silent %s/<+Class+>/\=expand('%:t:r')/g
	endif

	if search('<+DATE+>')
		silent %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
	endif
	
	
	if search('<+CURSOR+>')
		execute 'normal! "_da>'
	endif


endfunction

"}}}

" Usefull{{{
" 'Магический путь'
set path=.,,**
"
" :retab ( + set et!, set tabstop)

" }}}

" TagBar Options{{{
" Показывать окно слева
"let g:tagbar_left = 1

" Ширина окна
"let g:tagbar_width = 30

" Показывать стрелки вместо +/-
"let g:tagbar_iconchars = ['>', '<']

" Не сортировать
"let g:tagbar_sort = 0
" }}}

" MiniBuffer Options{{{
"  let g:miniBufExplMapWindowNavVim = 1 
"  let g:miniBufExplMapWindowNavArrows = 1 
"  let g:miniBufExplMapCTabSwitchBufs = 1 
"  let g:miniBufExplModSelTarget = 1 
"}}}

set t_Co=256 " использовать больше цветов в терминале
"autocmd! bufwritepost $VIM/_vimrc source $VIM/_vimrc


set hidden " не выгружать буфер когда переключаешься на другой
set mouse=a " включает поддержку мыши при работе в терминале (без GUI)
set showcmd " показывать незавершенные команды в статусбаре (автодополнение ввода)
set showmatch " показывать первую парную скобку после ввода второй

"" Формат строки состояния
" fileformat - формат файла (unix, dos); fileencoding - кодировка файла;
" encoding - кодировка терминала; TYPE - тип файла, затем коды символа под курсором;
" позиция курсора (строка, символ в строке); процент прочитанного в файле;
" кол-во строк в файле;
"set statusline=%F%m%r%h%w\ [FF,FE,TE=%{&fileformat},%{&fileencoding},%{&encoding}\]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%m%r%h%w\ [%{&fileformat},%{&fileencoding},%{&encoding}\]\ [TYPE=%Y]\ [row=%04l,col=%04v][%p%%]
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%* 

" Изменяет шрифт строки статуса (делает его не жирным)
hi StatusLine gui=reverse cterm=reverse
set laststatus=2 " всегда показывать строку состояния
set noruler "Отключить линейку

"" Подсвечивать табы и пробелы в конце строки
"set list " включить подсветку
"set listchars=tab:>-,trail:- " установить символы, которыми будет осуществляться подсветка
"Проблема красного на красном при spellchecking-е решается такой строкой в .vimrc
"highlight SpellBad ctermfg=Black ctermbg=Red
"au BufWinLeave *.* silent mkview " при закрытии файла сохранить 'вид'
"au BufWinEnter *.* silent loadview " при открытии - восстановить сохранённый

set visualbell " вместо писка бипером мигать курсором при ошибках ввода
"set whichwrap=b,<,>,[,],l,h " перемещать курсор на следующую строку при нажатии на клавиши вправо-влево и пр.

"" НАСТРОЙКИ ВНЕШНЕГО ВИДА
" Установка шрифта (для Windows и Linux)
" настройка внешнего вида для GUI
if has('gui')
    " отключаем графические табы (останутся текстовые,
    " занимают меньше места на экране)
"    set guioptions-=e
    " отключить показ иконок в окне GUI (файл, сохранить и т.д.)
    set guioptions-=T
endif


"НАСТРОЙКИ ПЕРЕКЛЮЧЕНИЯ РАСКЛАДОК КЛАВИАТУРЫ
"" Взято у konishchevdmitry
"set keymap=russian-jcukenwin " настраиваем переключение раскладок клавиатуры по <C-^>
"set iminsert=0 " раскладка по умолчанию - английская
"set imsearch=0 " аналогично для строки поиска и ввода команд
"function! MyKeyMapHighlight()
   "if &iminsert == 0 " при английской раскладке статусная строка текущего окна будет серого цвета
      "hi StatusLine ctermfg=White guifg=White
   "else " а при русской - зеленого.
      "hi StatusLine ctermfg=DarkRed guifg=DarkRed
   "endif
"endfunction
"call MyKeyMapHighlight() " при старте Vim устанавливать цвет статусной строки
"autocmd WinEnter * :call MyKeyMapHighlight() " при смене окна обновлять информацию о раскладках
"""" использовать Ctrl+F для переключения раскладок
"cmap <silent> <C-L> <C-^>
"imap <silent> <C-L> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
"nmap <silent> <C-L> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
"vmap <silent> <C-L> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv



"set diffexpr=MyDiff()
"function MyDiff()"{{{
  "let opt = '-a --binary '
  "if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  "if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  "let arg1 = v:fname_in
  "if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  "let arg2 = v:fname_new
  "if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  "let arg3 = v:fname_out
  "if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  "let eq = ''
  "if $VIMRUNTIME =~ ' '
    "if &sh =~ '\<cmd'
      "let cmd = '""' . $VIMRUNTIME . '\diff"'
      "let eq = '"'
    "else
      "let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    "endif
  "else
    "let cmd = $VIMRUNTIME . '\diff'
  "endif
  "silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction"}}}

function QuickFix_Toggle() "{{{
	if exists("g:quickfix_open") == 0
		let g:quickfix_open = 0
	endif

	if g:quickfix_open == 0
		:copen "%"
		let g:quickfix_open = 1
	else
		:cclose
		let g:quickfix_open = 0
	endif
endfunction " }}}

"
"call QuickFix_Toggle()


"au FileType haskell :call IDE_Layout()
au BufEnter *.vim :call VimFileSettings()
au BufEnter .vimrc :call VimrcSettings()
au BufEnter *.el :call UnicodeSupport()
au BufEnter *.hs :call HaskellSettings()
au BufEnter *.py :call PythonSettings()
au BufEnter _vimsh_ :call VimShellSettings()

au BufEnter *.cpp :call Cpp_Cpp_Settings()
au BufEnter *.c   :call Cpp_Cpp_Settings()
"au BufEnter *.h   :call Cpp_H_Settings()



let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlight_more_types = 1

function VimFileSettings() "{{{
	:call UnicodeSupport()
	set foldmethod=marker
	set foldenable
	set foldcolumn=2
endfunction " }}}

function Cpp_Cpp_Settings()
	call IDE_Layout()

	set smarttab
	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
	
	"set smartindent
	set cindent
	set cinoptions=(s,m1


endfunction

function VimrcSettings() " {{{
	set encoding=cp1251
	set fileencoding=utf-8
	"set encoding=utf-8
	set foldmethod=marker
	set foldenable
	set foldcolumn=2
	
	set smarttab
	"set noet
endfunction " }}}

function UnicodeSupport() " {{{
	if has("gui_running") 
		set guifont=DejaVu_Sans_Mono:h10:cRUSSIAN::
		"set encoding=utf-8
	endif
endfunction " }}}


function IDE_Layout() " {{{
	"call QuickFix_Open()
	":TagbarToggle
	map <F2> :cprevious <cr>
	map <F3> :cnext <cr>
endfunction
" }}}


function GlobalSettings() " {{{
	map <M-F2> :cn <cr>
	map <M-F1> :cp <cr>	
	map <M-F3> :call QuickFix_Toggle() <cr>

	imap <M-F2> :cn <cr>
	imap <M-F1> :cp <cr>	
	imap <M-F3> :call QuickFix_Toggle() <cr>

endfunction
"}}}

call GlobalSettings()

function HaskellSettings()"{{{
	" Make search path
	let b_ghc_staticoptions=[]
	let b_ghc_staticoptions_=[]
	
	try
		
		let sfile=readfile(expand('%'))
	
		for s in sfile
			if match(s,"^import .* ") != -1
		"		let imports_count = substitute(s,'[a-zA-Z]*\.[a-zA-Z]*',"!","g")
				let imports_count = split(s,"[\.]")
				for i in imports_count
					let b_ghc_staticoptions_ += ['../']
				endfor
				let b_ghc_staticoptions_s =join(b_ghc_staticoptions_,'')
				if count(b_ghc_staticoptions,b_ghc_staticoptions_s) == 0
					let b_ghc_staticoptions += [b_ghc_staticoptions_s]				
				endif
				let b_ghc_staticoptions_ = []
			endif
		endfor
		
		
		let b_ghc_staticoptions_s =join(b_ghc_staticoptions,' -i')
		"let b:ghc_staticoptions="-i" . b_ghc_staticoptions_s
	catch 
		
	endt

	compiler ghc
	set et
	"set noet
	set softtabstop=4
	set tabstop=4
	set shiftwidth=4
	
	map <F12> :w <cr> :make <cr>
"	map <F11> :w <cr> :!ghci % <cr>
	map <F7>  :w <cr> :GHCi main <cr>
	map <F11>  :w <cr> :execute ":!ghci" expand('%') b:ghc_staticoptions <cr>

	nm <silent> ,a :call FixImports() <cr>
	nm <silent> und :call Haskell_add_undefined() <cr>

	map <F8> :TagbarToggle <cr>
	"call tagbar#autoopen(1)
		
	set foldenable
	set foldmethod=marker
	set foldcolumn=2

	set ai

	filetype plugin on
	let s:loaded_unicodehaskell = 1
	if has("gui_running") 
		set guifont=DejaVu_Sans_Mono:h10:cRUSSIAN::
"		set encoding=utf-8
"		set guifont=Consolas:h11:cRUSSIAN::
"	        set guifont=Lucida_Console:h10:cRUSSIAN::
"		set guifont=DejaVu_Sans_Mono:h9 
	"	set guifont=Monospace:h10
	endif
	
	
	"if exists('b:did_ftplugin_ghcmod') && b:did_ftplugin_ghcmod
	"	map <C-F11> :w <cr> :GhcModCheck <cr>
	"	map <F9> :GhcModExpand <cr>
		"autocmd BufWritePost *.hs GhcModCheckAsync
	"endif
	

endfunction
"}}}


let python_highlight_all = 1 	

function PythonSettings() "{{{
	set ai
	set smarttab

	set tabstop=4

	map <F12> :w <cr> :call PyCheckErrors() <cr>
	map <F11> :w <cr> :call PyRun() <cr>

	setlocal keywordprg=pydoc

endfunction "}}}



:colorscheme desert

function PyRun() " {{{
	:!python -i %
endfunction
"}}}

function PyCheckErrors() "{{{
	let err = tempname()
	let fname = substitute(expand('%'),".py"," ","")
	execute 'silent !python -c "import ' fname  '"' '2>' err
	let errs = readfile(err)
	if !empty(errs)
		echohl WarningMsg
		for item in errs
			:echo item
		endfor
		echohl None
	else
		redraw!
	endif
    call delete(err)	
endfunction "}}}

"function GHCi_Eval() "{{{
	"let command_s = @*
	"let tmp = "tmp"
	"let outtmp = "outtmp"
	"call writefile([command_s],tmp)
            "execute 'silent !ghci ' '%' '<' tmp '>' outtmp
	"let g:result = readfile(outtmp)
"endfunction
""}}}

function Haskell_add_undefined() " {{{
	let line = getline(".")
	":let repl = substitute(line, '\a', "*", "g")
	let new_line = line . " undefined"
	call setline(".", new_line)
endfunction
" }}}

" Example vimrc file to bind a key to fix-imports.

"nm <silent> ,a :call FixImports()<cr>

" Run the contents of the current buffer through the fix-imports cmd.  Print
" any stderr output on the status line.
" Remove 'a' from cpoptions if you don't want this to mess up #.
function FixImports() "{{{
    let out = tempname()
    let err = tempname()
    let tmp = tempname()
    " Using a tmp file means I don't have to save the buffer, which the user
    " didn't ask for.
    execute 'write' tmp
    execute 'silent !fix-imports -v' expand('%') '<' tmp '>' out '2>' err
    let errs = readfile(err)
    if v:shell_error == 0
        " Don't replace the buffer if there's no change, this way I won't
        " mess up fold and undo state.
        call system('cmp -s ' . tmp . ' ' . out)
        if v:shell_error != 0
            " Is there an easier way to replace the buffer with a file?
            let old_line = line('.')
            let old_col = col('.')
            let old_total = line('$')
            %d
            execute 'silent :read' out
            0d
            let new_total = line('$')
            " If the import fix added or removed lines I need to take that
            " into account.  This will be wrong if the cursor was above the
            " import block.
            call cursor(old_line + (new_total - old_total), old_col)
            " The reload will forget fold state.  It was open, right?
            if foldclosed('.') != -1
                execute 'normal zO'
            endif
        endif
    endif
    call delete(out)
    call delete(err)
    call delete(tmp)
    redraw!
    if !empty(errs)
        echohl WarningMsg
        echo join(errs)
        echohl None
    endif
endfunction 
"}}}

function NoUnicodeHaskell() " {{{
	let g:loaded_unicodehaskell = 1 
endfunction
"}}}



