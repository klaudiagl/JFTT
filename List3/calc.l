%{
#include <iostream>
#include <cstdlib>
#include "calc.tab.h"


%}

%x COMMENT

%%
^#                              BEGIN(COMMENT);
\\\n                            ;
[ \t]+                          ;
<COMMENT>{
    .|\\\n                      ;
    \n                          BEGIN(INITIAL);
}

\n                              return NEWLINE;
[0-9]+                          { yylval = atoi(yytext); return NUM; }
[-+()=/*\n\^%]			{return *yytext;}
.                               ;
%%
