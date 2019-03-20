all: lexer parser
	g++ -std=c++11 methods.cpp calc.tab.c lex.yy.c -lfl -o calc

lexer: 
	flex calc.l

parser:
	bison -d calc.y

clean:
	rm calc.tab.h calc.tab.c lex.yy.c calc
