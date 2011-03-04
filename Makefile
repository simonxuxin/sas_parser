parse_strategy : sas.tab.c lex.yy.c expr_node.c variable.c
	gcc -o parse_strategy lex.yy.c sas.tab.c expr_node.c variable.c

lex.yy.c : sas.l
	flex sas.l

sas.tab.c : sas.y
	bison -d -v sas.y

