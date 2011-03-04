%{
#include <string.h>

#include "sas.tab.h"

struct keyword {
	char *name;
	int code;
} keywords[] = {
	"if", 	IF,
	"then", THEN,
	"else", ELSE,
	"in", 	IN,
	"end",	END,
	"do", 	DO,
	"and", 	AND,
	"or", 	OR,
	"not", 	NOT,
	NULL, 	0,
};

int lineno = 1;

%}

ws		[ \t]+
nl		\n

number  (([0-9]+)|([0-9]*\.[0-9]+))([eE][-+]?[0-9]+)?
string	\'[^\'\n]*\'|\"[^\"\n]*\"
id		[a-zA-Z][a-zA-Z0-9_]*

comparison  "<>"|"<"|">"|"<="|">="

%x		comment

%%

\/\*							{ BEGIN(comment); }
<comment>[^\*\n]+				{}
<comment>\*+[^\*\/\n]+			{}
<comment>\n						{ lineno++; }
<comment>\*+\/					{ BEGIN(INITIAL); }

{ws}							{}	
{nl}							{ lineno++; }

{string}						{
									yylval.string = strdup(yytext + 1);
									yylval.string[strlen(yytext) - 2] = '\0';
									return STRING;
								}

{id}							{
									int i;
									for(i = 0; keywords[i].name != NULL; i++)
										if(strcasecmp(keywords[i].name, yytext) == 0)
											return keywords[i].code;

									yylval.string = strdup(yytext);
									return ID;
								}

{number}    					{ yylval.string = strdup(yytext); return NUMBER; }

{comparison}					{ return COMPARISON; }

.								{ return yytext[0]; }

%%
