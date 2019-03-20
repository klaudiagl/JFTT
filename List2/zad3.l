
%{
#include <stdbool.h>

bool print_doc = true;
%}


%x COMMENT
%x MULTI_COMMENT
%x DOC_COMMENT
%x STRING

%%
\"		BEGIN(STRING);  ECHO;
\/\/		BEGIN(COMMENT);
\/\*    	BEGIN(MULTI_COMMENT);
\/\/\/    	BEGIN(DOC_COMMENT); if(print_doc) ECHO;

<STRING>{   
	\\\"		ECHO;
	\"		ECHO; BEGIN(INITIAL);
	.		ECHO;
}

<COMMENT>{
	.*\\\n		;
	.		;      
	[^\\]\n		BEGIN(INITIAL);
}


<MULTI_COMMENT>{
	.|\n		;
	\*\/		BEGIN(INITIAL);
}


<DOC_COMMENT>{
	.		if(print_doc) ECHO;
	.?\n		if(print_doc) ECHO; BEGIN(INITIAL);
}

%%

int yywrap() {
    return 1;
}

int main() {
    return yylex();
}
