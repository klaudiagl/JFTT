%{
#include <iostream>
#include <sstream>
#include <math.h>

extern int yylineno;
bool err = false;
std::ostringstream oss;
int yylex();
void yyerror(const char *s);
%}

%token NUM
%token NEWLINE
%token '('
%token ')'
%left '+' '-' 
%left '*' '/' '%'
%right '^'
%precedence NEG

%%
input:
    %empty
    | input line
;

line:
    NEWLINE
    | expr NEWLINE   {
                        if(!err) {
                            oss << "\nResult: " << $1 << std::endl;
                            std::string s = oss.str();
                            oss.str("");
                            oss.clear();
                            std::cout << s << std::endl;
                        } else {
                            oss.str("");
                            oss.clear();
                            std::cout << std::endl;
                            err = false;
                        }
                    }
    | error NEWLINE 
;

expr:
    NUM			{ $$ = $1; oss << $1 << " ";}
    | expr '+' expr	{ $$ = $1+ $3; oss << "+ "; }
    | expr '-' expr	{ $$ = $1 - $3; oss << "- "; }
    | expr '*' expr	{ $$ = $1 * $3; oss << "* "; }

    | expr '/' expr	{ 
                        	oss << "/ ";
                                if($3 == 0) {
                                	yyerror("");
                                } else {
                                	$$ = $1 / $3;
                                }
                        }

    | expr '%' expr	{
                        	oss << "% ";
                               	if($3 == 0) {
		                        yyerror("");
                                } else {
					$$ =(($1 % $3)+$3)% $3;
                                }
                        }

    | '-' expr %prec NEG	{ $$ = -$2; oss << "- "; }

    | expr '^' expr	{
                        	oss << "^ ";
                                if($3 < 0) {
                                	yyerror("");
                                } else {
                                	$$ = pow($1, $3);
                                }
                        }

    | '(' expr ')'	{ $$ = $2; }
;
%%

void yyerror(const char *s) {
	err = true;
	fprintf (stderr, "Błąd.\n");
}

int main() {
	return yyparse();
}
