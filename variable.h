#ifndef _VARIABLE_H
#define _VARIABLE_H

#include <stdlib.h>

typedef struct variable {
	char name[32];
	int type; /* 0 -> numeric, 1 -> string */
	struct variable *next;
} Variable;

void add_variable(char *, int);
void pr_variables();
Variable * make_variable(char *, int);
#endif
