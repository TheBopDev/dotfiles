" TheBopDev

" Remove annoying double tap enter key to open vim.
set shortmess=a
set cmdheight=2

" Tip - Pressing '%' on one element of a matching pair will jump to the other element of the matching pair. 
"     - If you press '%' on the below '{' you will be taken to tips '}'
" { vimrc config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""";
" Setup leader key first, since it's global
  let mapleader = ","

" { UI related;
  colorscheme desert   " Preference;
	set background=dark  " Preference
  set guifont=Consolas:h11:cANSI   " Choose your font. Default size = 11.
	nnoremap <leader><F12> :call FontSizePlus()<CR>
	nnoremap <leader><S-F12> :call FontSizeMinus()<CR>
	nnoremap <leader><F11> :call FontCycle()<CR>
  set visualbell       " Blinks your screen
  set showmode " Insert / normal / visual / visual block?
  set number   " Show the line of code # on left-hand side.
  set matchtime=2  " How many 10ths of a second to blink when matching brackets
  set laststatus=2 " Always display status line
  set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


" Makes jumping between code easier.
" ex: 6j moves cursor down 6 lines. 23k moves cursor up 23 lines.
  set relativenumber 

" Show (partial) command in last line of the screen. 
" Turn this off if terminal is too slow.
"   - Show number of characters when selecting on a line.
"   - If selecting >1 line, show # of lines
"   - If selecting a block, show size of characters {lines}x{columns}
  set showcmd

" Not needed on linux... Useful on windows.
" <ALT>j will move cursor down a window.
" <ALT>J will move the entire window down.
" set winaltkeys=no
" nnoremap <M-h> <C-w>h
" nnoremap <M-j> <C-w>j
" nnoremap <M-k> <C-w>k
" nnoremap <M-l> <C-w>l
" 
" nnoremap <M-H> <C-w>H
" nnoremap <M-J> <C-w>J
" nnoremap <M-K> <C-w>K
" nnoremap <M-L> <C-w>L

" Depreciated on Linux. Just open new terminal for each instance... Useful on windows.
" Arrow keys will resize current windows
"	nnoremap <RIGHT> :vertical resize +2<CR>
"	nnoremap <LEFT> :vertical resize -2<CR>
"	nnoremap <UP> :resize -2<CR>
"	nnoremap <DOWN> :resize +2<CR>


" } End of UI



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" { General settings
  set nocompatible " This isn't vi
  set hidden " hide errors from unsupported features
  set wildmenu " Auto completion of commands
  set wildmode=longest:full,full
  set wildignorecase
  set wildignore=\*.git/\*
	set ttyfast
  set encoding=utf8
	set autowrite
  set autoread " Re-read files that have been edited outside of vim
	set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after


	" ,a adds a filename to the buffer, and ,b hops to the file
  nnoremap <leader>a :argadd <c-r>=fnameescape(expand('%:p:h'))<cr>/*<C-d>
  nnoremap <leader>b :b <C-d>



" } End of General settings

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" { Convenience

" Return cursor to last position when opening files
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif



" Don't press shift to save/quit anymore. (I'm lazy)
  noremap ; :


" Make backspace behave more intuitively
  set backspace=eol,start,indent
  set whichwrap+=<,>,h,l


" Improve search functionality
  set ignorecase " Ignore case first
  set smartcase  " Unless we want case specifics
  set hlsearch   " highlighting where your cursor is
  set incsearch  " pressing 'n' will go to next instance of search term in current file
  set showmatch  " Show matching brackets

" While in visual mode, search for the highlighted text by pressing '*' or '#'
" '#' key searches up, while '*' searches down the file.
	vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
	vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>



" } End of Convenience

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" { Coding aids
  syntax on " Syntax highlighting
  set filetype " Different syntax for different languages
  set matchpairs=(:),{:},[:]
  set undolevels=5000 " 'u' to undo, '<Ctrl>r' to redo
" Helping with blocks
" inoremap ( ()<LEFT>
  inoremap (<CR> (<CR><TAB><CR>)<ESC>kA
  inoremap () ()
" inoremap { {}<LEFT>
  inoremap {<CR> {<CR><TAB><CR>}<ESC>kA
" inoremap {{ {
" inoremap [ []<LEFT>
  inoremap [<CR> [<CR><TAB><CR>]<ESC>kA
  inoremap [] []
" Place highlighted section inside a matching pair
  vnoremap -( <ESC>`>a)<ESC>`<i(<ESC>
  vnoremap -[ <ESC>`>a]<ESC>`<i[<ESC>
  vnoremap -{ <ESC>`>a}<ESC>`<i{<ESC>
  vnoremap -" <ESC>`>a"<ESC>`<i"<ESC>
  vnoremap -' <ESC>`>a'<ESC>`<i'<ESC>
  " End the line, adding a semicolon
  inoremap <S-CR> <ESC>A;<ESC>o
  noremap <S-CR> A;<ESC>j
" }}}}}} Ignore this comment

" 
  set conceallevel=1

" Indentation
  set shiftwidth=2  " 
  set tabstop=2     " How wide should a tab be
  set softtabstop=2 " Use spaces instead of tabs
	filetype plugin on
	filetype indent on
	noremap p p=`[<C-o>
	noremap P P=`[<C-o>
	set splitbelow
	set splitright

" Code folding
  set foldmethod=syntax  " How to select when to fold
  set foldnestmax=10     " Maximum amount of nesting to fold
  set foldlevel=2        "  
" set nofoldenable       " Open files with all code expanded by default


" Scrolling
	set scrolloff=8
	set sidescrolloff=15
	set sidescroll=1


" Skeleton files
autocmd BuFnewFile *.c				0r ~/.vim/templates/skeleton.c
autocmd BuFnewFile *.h				0r ~/.vim/templates/skeleton.h
autocmd BuFnewFile *.vhdl			0r ~/.vim/templates/skeleton.vhdl



" } End of Coding aids

" { Helper functions
  function! HasPaste()
    if &paste
      return 'PASTE MODE  '
    endif
    return ''
  endfunction


  " Better searching
		" Setup helper function before-hand
	function! CmdLine(str)
		call feedkeys(":" . a:str)
	endfunction
		" Visual mode searching
	function! VisualSelection(direction, extra_filter) range
		let l:saved_reg = @"
		execute "normal! vgvy"

		let l:pattern = escape(@", "\\/.*'$^~[]")
		let l:pattern = substitute(l:pattern, "\n$", "", "")

		if a:direction == 'gv'
			call CmdLine("Ack '" . l:pattern . "' " )
		elseif a:direction == 'replace'
			call CmdLine("%s" . '/'. l:pattern . '/')
		endif

		let @/ = l:pattern
		let @" = l:saved_reg
	endfunction

" Change font-size on the fly.
	" First declare some global variables
	let g:font_types = ['Consolas', 'Courier\ New']
	let g:font_sizes = [10, 12]
	let g:font_index = 0
	let g:font_size  = g:font_sizes[g:font_index]

	" Cycle to next font
	function! FontCycle ()
		let g:font_index = (g:font_index + 1) % len(g:font_types)
		let g:font_size  = g:font_sizes[g:font_index]
		call ResetFont()
	endfunction

	" Reset to initial values (what's first in the font_types)
	function! ResetFont ()
		if has('gui_running')
			exe ':set guifont=' . g:font_types[g:font_index] . '\:h' . string(g:font_size) . '\:cANSI'
		endif
	endfunction
	" Initialize the font
	call ResetFont()

	" Increase font size
	function! FontSizePlus ()
		let g:font_size = g:font_size + 0.5
		call ResetFont()
	endfunction
	" Decrease font size
	function! FontSizeMinus ()
		let g:font_size = g:font_size - 0.5
		call ResetFont()
	endfunction




" } End of Helper functions






""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" } End of vimrc config settings
" Helpfil tips section below


" !!! IMPORTANT FOR NEW VIM USERS !!!
" !!! READ ALL !!!
" If you ever get stuck, press 'esc' until you are in normal mode.
" From normal mode, pressing ':q!' will QUIT WITHOUT SAVING.
" 
" If you want to save an existing file, do ':w' or ':w!' for files that require admin/sudo privelages.
" To save a file with a new file name, do ':sav /path/to/filename.c'
" Doing ':sav filename.c' MAY save the file to your LOCAL HOME DIRECTORY ($HOME/filename.c)



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" { Navigation

" When in normal mode, you place your cursor on either one of a matching pair (), [], or {} and press the '%' key. This will jump you to it's match.

" To jump to beginning of file, type 'gg'
" To jump to end of file, type 'G'
" To jump to beginning of line, type '0'
" To jump to end of line, type '$'

" } End of Navigation


" { Marks
" Marks behave like bookmarks. You place bookmarks on your current cursor position, allowing you to easily return to that section of code in the future.

" To place a mark, press the 'm' key followed by a letter.
" * lower case letters indicate file-specific marks.
" * UPPER CASE letters indicate global marks. 

" Command                   Description
" ma          set a mark at current cursor location.
" 'a          jump to line of mark a (first non-blank char)
" `a          jump to position (line and column) of mark a
" d'a         delete from current line to line of mark a
" d`a         delete from current corsor position to position of mark a
" c'a         change text from current line to line of mark a
" y'a         yank text to unnamed buffer from cursor to position of mark a
" :marks      list all current marks
" :marks aB   list marks a, B

" To delete mark 'a' for example, enter the command ':delmarks a'
" To delete a range of marks for example, enter the command ':delmarks a-z'
" To delete all marks, enter the command ':delmarks!'


" } End of marks
