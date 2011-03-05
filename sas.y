%{
#include <stdio.h>

#include "variable.h"
#include "node.h"

#define YYERROR_VERBOSE

void yyerror(const char *);
int yywrap() { return 1; }

extern int lineno;
extern FILE *yyin;

int is_string = 0;

%}

%union {
	char *string;
	struct expr_node *expr;
}

%token IF
%token THEN
%token ELSE
%token DO
%token END
%token IN
%token OR
%token AND
%token NOT

%token<string> STRING
%token<string> NUMBER

%token<string> COMPARISON

%token<string> ID

%type<expr> expr c_expr assign_statement

%nonassoc THEN
%nonassoc ELSE

%left OR
%left AND
%right COMPARISON
%left '+' '-'
%left '*' '/'
%right '='

%%

input: statements 					{ pr_variables(); }
	 ;

statements: statement
		  | statements statement
		  ;

statement: if_statement
		 | assign_statement
		 ;

if_statement: IF c_expr THEN then_clause
			| IF c_expr THEN then_clause ELSE else_clause
			;

c_expr: expr COMPARISON expr 		{ $$ = make_expr_node($1, $3, $2);  add_variable(get_expr_lnode($$), is_string); }	
	  | expr '=' expr				{ $$ = make_expr_node($1, $3, "=");  add_variable(get_expr_lnode($$), is_string); }
	  | in_clause
	  | c_expr AND c_expr
	  | c_expr OR c_expr
	  ;

in_clause: expr in_op '(' in_list ')'
		 ;

in_op: IN
	 | NOT IN
	 ;

in_list: expr
	   | in_list ',' expr
	   ;

expr: NUMBER			{ $$ = make_expr_node(NULL, NULL, $1); is_string = 0; }
	| STRING			{ $$ = make_expr_node(NULL, NULL, $1); is_string = 1;}
	| ID				{ $$ = make_expr_node(NULL, NULL, $1); }
	| expr '+' expr		{ $$ = make_expr_node($1, $3, "+"); }
	| expr '-' expr		{ $$ = make_expr_node($1, $3, "-"); }
	| expr '/' expr		{ $$ = make_expr_node($1, $3, "/"); }
	| expr '*' expr		{ $$ = make_expr_node($1, $3, "*"); }
	| '(' expr ')'		{ $$ = $2; }
	;

then_clause: statement
		   | DO ';'  statements END ';'
		   ;

assign_statement: ID '=' expr ';'				{ $$ = make_expr_node(make_expr_node(NULL, NULL, $1), $3, "="); add_variable(get_expr_lnode($$), is_string); }
				;

else_clause: statement
		   | DO ';' statements END ';'
		   ;

%%

void yyerror(const char *s) {
	fprintf(stderr, "at line %d: %s\n", lineno, s);
}

int main(int argc, char **argv) {
	if(argc != 2) {
		fprintf(stderr, "usage: %s <sas strategy/segmentation file>\n", *argv);
		return 1;
	} else {
		FILE *fp;
		if((fp = fopen(*(argv + 1), "r")) != NULL) {
			yyin = fp;
			return(yyparse());
		} else {
			fprintf(stderr, "Cannot open file: %s\n", *(argv + 1));
			return 1;
		}
	
	}
}
