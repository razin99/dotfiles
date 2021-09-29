" -- Markdown file settings
"   turn on spellcheck
"   TODO: bind g] to next err, or anything better than ]s
"   TODO: bind g[ to prev err, or anything better than [s
"   bind =s to Telescope spell_suggest
"   tabs -> 2 spaces

setlocal spell spelllang=en_gb
nnoremap <buffer> =s :Telescope spell_suggest<CR>
setlocal shiftwidth=2 tabstop=2
