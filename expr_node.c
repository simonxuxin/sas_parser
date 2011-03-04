#include "node.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

ExprNode *
make_expr_node(ExprNode *l, ExprNode *r, char *v)
{
	ExprNode *p = (ExprNode *)malloc(sizeof(ExprNode));
	p->left = l;
	p->right = r;
	strcpy(p->value, v);

	return p;
}

void
pr_expr_node(ExprNode *p)
{
	if(p == NULL) return;

	printf("value: %s\n", p->value);

	pr_expr_node(p->left);
	pr_expr_node(p->right);
}

char *
get_expr_lnode(ExprNode *p)
{
	if(p == NULL) return NULL;
	if(p->left == NULL)
		return p->value;
	else
		get_expr_lnode(p->left);
}
