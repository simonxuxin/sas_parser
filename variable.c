#include "variable.h"
#include "_variable.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void
add_variable(char *n, int t)
{
	printf("get variable: %s\n", n);
	Variable *p, *q;
	for(p = vhead; p && strcasecmp(p->name, n) <= 0; p = p->next);
	
	if(p && strcasecmp(p->name, n) == 0) return; /** already there **/
	
	for(q = vhead; q && q->next != p; q = q->next);

	Variable *v = malloc(sizeof(Variable));
	strcpy(v->name, n);
	v->type = t;
	v->next = NULL;

	if(q == NULL)
		/* head is null */
		vhead = v;
	else
		q->next = v;
}

void
pr_variables()
{
	Variable *p;
	for(p = vhead; p; p = p->next)
		printf("%s|%d\n", p->name, p->type);
}
