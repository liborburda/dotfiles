" darkcourses colours for (g)Vim
" Author:  bohoomil
" Date:    May, 2011
" Release: 1.0 final
"
" This theme is supposed to be used
" with darkcourses .Xdefaults colour settings.
" GUI part is .Xdefaults independent.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="darkcourses"

" term zone
"
hi Normal                  ctermfg=none
hi Boolean                 ctermfg=13
hi Comment                 ctermfg=8   cterm=none
hi Conditional             ctermfg=11
" hi Constant                ctermfg=3
hi Cursor                  ctermbg=12
hi Debug                   ctermfg=13
hi Define                  ctermfg=11
hi Delimiter               ctermfg=8
hi DiffLine                ctermfg=4 
hi DiffOldLine             ctermfg=1
hi DiffOldFile             ctermfg=1
hi DiffNewFile             ctermfg=2
hi DiffAdded               ctermfg=10
hi DiffRemoved             ctermfg=1
hi DiffChanged             ctermfg=6
hi Directory               ctermfg=2
hi Error                   ctermfg=9   ctermbg=none
hi ErrorMsg                ctermfg=9   ctermbg=none
hi Exception               ctermfg=13
hi Float                   ctermfg=14
hi FoldColumn              ctermfg=6   ctermbg=0
hi Folded                  ctermfg=6   ctermbg=0
" hi Function                ctermfg=3
hi Identifier              ctermfg=11
hi IncSearch               ctermbg=207 ctermfg=235
hi Keyword                 ctermfg=11
hi Label                   ctermfg=11
hi LineNr                  ctermfg=8 
hi Macro                   ctermfg=11
hi ModeMsg                 ctermfg=3
hi MoreMsg                 ctermfg=14
hi NonText                 ctermfg=8 
hi Number                  ctermfg=4
hi Operator                ctermfg=130
hi PreCondit               ctermfg=10  cterm=none
hi PreProc                 ctermfg=104
hi Question                ctermfg=14
hi Repeat                  ctermfg=14
hi Search                  ctermfg=207 ctermbg=235
hi SpecialChar             ctermfg=13
hi SpecialComment          ctermfg=108
hi Special                 ctermfg=13
hi SpecialKey              ctermfg=10
hi Statement               ctermfg=4
hi StorageClass            ctermfg=6
hi String                  ctermfg=10
hi Structure               ctermfg=12
hi Tag                     ctermfg=5
hi Title                   ctermfg=7   ctermbg=none cterm=bold
hi Todo                    ctermfg=10  ctermbg=0
hi Typedef                 ctermfg=9
hi Type                    ctermfg=5
hi Underlined              ctermfg=104 ctermbg=232
hi VertSplit               ctermfg=65  ctermbg=235
hi Visual                  ctermfg=210 ctermbg=235
hi VisualNOS               ctermfg=210 ctermbg=235
hi WarningMsg              ctermfg=9   
hi WildMenu                ctermbg=0   ctermfg=104
hi CursorLine              ctermbg=0   cterm=none

" statusline
hi StatusLine              ctermfg=7   ctermbg=0    cterm=none
hi StatusLineNC            ctermfg=0   ctermbg=7
hi StatusModFlag           ctermfg=9   ctermbg=0    cterm=bold
hi StatusRO                ctermfg=6   ctermbg=0    cterm=bold
hi StatusHLP               ctermfg=2   ctermbg=0    cterm=bold
hi StatusPRV               ctermfg=3   ctermbg=0    cterm=bold
hi StatusFTP               ctermfg=4   ctermbg=0    cterm=bold

" spellchecking
hi SpellLocal              ctermfg=15  ctermbg=14  cterm=underline
hi SpellBad                ctermfg=15  ctermbg=9   cterm=underline
hi SpellCap                ctermfg=15  ctermbg=12  cterm=underline
hi SpellRare               ctermfg=15  ctermbg=13  cterm=underline

" pmenu
hi PMenu                   ctermfg=7    ctermbg=0
hi PMenuSel                ctermfg=none ctermbg=8 

" html
hi htmlTag                 ctermfg=12
hi htmlEndTag              ctermfg=12
hi htmlTagName             ctermfg=3

" perl
hi perlSharpBang           ctermfg=10  cterm=none
hi perlStatement           ctermfg=13
hi perlStatementStorage    ctermfg=1
hi perlVarPlain            ctermfg=6
hi perlVarPlain2           ctermfg=11

" ruby
hi rubySharpBang           ctermfg=10  cterm=none

" mini buffer explorer
hi MBENormal               ctermfg=8
hi MBEChanged              ctermfg=1
hi MBEVisibleNormal        ctermfg=5
hi MBEVisibleNormalActive  ctermfg=13
hi MBEVisibleChanged       ctermfg=7
hi MBEVisibleChangedActive ctermfg=9

if ($TERM =~ "rxvt" || "xterm")
	hi Comment             ctermfg=8   cterm=italic
endif

if ($TERM =~ "screen" || "tmux")
	hi Comment             ctermfg=8   cterm=standout
endif

