call plug#begin('~/.local/share/nvim/plugged')
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-goimports'
Plug 'tpope/vim-fugitive'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'julian/vim-textobj-variable-segment'
Plug 'kana/vim-textobj-user'
call plug#end()

let g:fern#renderer = 'nerdfont'

augroup __fern__
 au!
 autocmd VimEnter * ++nested Fern . -drawer -stay -keep -toggle -reveal=%
augroup END

nnoremap ,t :<c-u>Fern . -drawer -stay -keep -toggle -reveal=%<cr>

set guifont=Sarasa
set tabstop=4
set softtabstop=0
set expandtab
set smarttab
" 改行後の空白を削除
autocmd BufWritePre * :%s/\s\+$//e

set number

set tabstop=4
set shiftwidth=4
"Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandt
"Get the 2-space go as the default when hit carriage return after the colon
autocmd FileType go setlocal ts=4 sts=4 sw=4
autocmd FileType js setlocal ts=2 sts=2 sw=2

nmap <silent> <Leader>d :LspDefinition<CR>
nmap <silent> <Leader>p :LspHover<CR>
nmap <silent> <Leader>r :LspReferences<CR>
nmap <silent> <Leader>i :LspImplementation<CR>
nmap <silent> <Leader>s :split \| :LspDefinition <CR>
nmap <silent> <Leader>v :vsplit \| :LspDefinition <CR>

" lsp settings {{{
let g:lsp_signs_error = {'text': ''}
let g:lsp_signs_warning = {'text': ''}
if !has('nvim')
  let g:lsp_diagnostics_float_cursor = 1
endif
let g:lsp_log_file = ''

let g:lsp_settings = {
      \ 'efm-langserver': {
      \   'disabled': 0,
      \   'allowlist': ['markdown'],
      \  }
      \ }

function! s:on_lsp_buffer_enabled() abort
  setlocal completeopt=menu
  setlocal omnifunc=lsp#complete
endfunction

augroup lsp_install
  au!
  au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" }}}

