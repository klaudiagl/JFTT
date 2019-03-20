	int num_lines=0, num_words=0;


%%
[ \t]+		printf(" ");
^[ \t\n]+
\n		num_lines++; printf("%s", yytext);
[^ \t\n]*	num_words++; printf("%s", yytext);

%%
int main(){
	yylex();
	printf( "\n# of lines = %d, # of words = %d\n", num_lines, num_words);
}
