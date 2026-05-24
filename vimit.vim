filetype plugin indent on

"set expandtab " makes tabs into spaces
set shiftwidth=0
set softtabstop=4
set tabstop=4

set number
set relativenumber
set cursorline

set smartindent
set smartcase
set ignorecase

set nowrap
set showmatch
set backspace=indent,eol,start
set signcolumn=yes
set list
set inccommand=split
set virtualedit=block

set sidescroll=0
set sidescrolloff=10
set scrolljump=1
set scrolloff=10

set undofile
set swapfile
set confirm

syntax on

let mapleader=' '
let localmapleader=','

nn	;		:

nn <leader>e	:Ex<CR>
" See also after/ftplugin/netrw.vim (:Ex -> :Rex)

nn <silent>	<ESC>	:nohl <CR>
nn	<C-s>	:write<CR>
nn	<C-M-s>	:write <BAR>source <BAR>echo "written&sauced"<CR>
nn	<C-q>	:quit<CR>

"nn <leader>b	:buffers<CR>
nn	<S-H>	:bp<CR>
nn	<S-L>	:bn<CR>

nn	<C-h>	<C-w>h
nn	<C-j>	<C-w>j
nn	<C-k>	<C-w>k
nn	<C-l>	<C-w>l

nm	<C-c>	gcc
vm	<C-c>	gc

tno	<C-ESC>	<C-\><C-n>

no		j		gj
no		k		gk

colorscheme wildcharm


function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
	" select the highlighting
	if i + 1 == tabpagenr()
	  let s ..= '%#TabLineSel#'
	else
	  let s ..= '%#TabLine#'
	endif

	" set the tab page number (for mouse clicks)
	let s ..= '%' .. (i + 1) .. 'T'

	" the label is made by MyTabLabel()
	let s ..= ' %{MyTabLabel(' .. (i + 1) .. ')} '
  endfor

  " after the last tab page fill with TabLineFill and reset tab page nr
  let s ..= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
	let s ..= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

:set tabline=%!MyTabLine()
