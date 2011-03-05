#include "variable.h"
#include "_variable.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void
add_variable(char *n, int t)
{
	Variable *p, *q;

	//printf("get variable : %s\n", n);
	if(vhead == NULL)
		vhead = make_variable(n, t);
	else {
		for(p = vhead; p && strcasecmp(p->name, n) < 0; p = p->next);
	
		if(p && strcasecmp(p->name, n) == 0) return; /** already there **/

		if(p == vhead) {
			Variable *v = make_variable(n, t);
			v->next = p;
			vhead = v;
		}
		else {
			for(q = vhead; q && q->next != p; q = q->next);
			Variable *v = make_variable(n, t);
			v->next = q->next;
			q->next = v;
		}
	}
}

Variable *
make_variable(char *n, int t)
{
	Variable *v = malloc(sizeof(Variable));
	strcpy(v->name, n);
	v->type = t;
	v->next = NULL;

	char *c;
	for(c = v->name; *c; c++)
		*c = tolower(*c);

	return v;
}

void
pr_variables()
{
	Variable *p;
	for(p = vhead; p; p = p->next)
		printf("%s|%c\n", p->name, p->type == 1 ? 'c' : 'n');
}
