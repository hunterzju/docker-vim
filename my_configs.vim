call plug#begin("~/.vim_runtime/my_plugins/")
 "Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }
 Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
 Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
 Plug 'airblade/vim-gitgutter'
 Plug 'zivyangll/git-blame.vim'
 Plug 'antiagainst/vim-tablegen'
 Plug 'hunterzju/mlir-vim'
 Plug 'rhysd/vim-clang-format'
 Plug 'prabirshrestha/vim-lsp'
 Plug 'mattn/vim-lsp-settings'
call plug#end()

" execute project related configuration in current directory
if filereadable(".workspace.vim")
    source .workspace.vim
endif 

" """""" YCM config
" set completeopt=menu,menuone
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_show_diagnostics_ui = 0
" let g:ycm_server_log_level = 'info'
" " 跳转到函数定义
" " nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
" nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
" nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
" " 跳回原位置
" " nnoremap <S-F12> <C-o>
" " Let clangd fully control code completion
" let g:ycm_clangd_uses_ycmd_caching = 0
" " Use installed clangd, not YCM-bundled clangd which doesn't get updates.
" let g:ycm_clangd_binary_path = "/usr/bin/clangd"

" LLVM Makefile highlighting mode
augroup filetype
  au! BufRead,BufNewFile *Makefile*     set filetype=make
augroup END

"""""""""""" LeaderF
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_WorkingDirectoryMode = 'Ac'

let g:Lf_ShortcutF = "<leader>ff"
"noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
nnoremap <C-F> :Leaderf rg -e
