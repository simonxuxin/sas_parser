#ifndef _NODE_H
#define _NODE_H

typedef struct node {
} Node;

typedef struct expr_node {
	struct expr_node *left;
	struct expr_node *right;
	char value[32];
} ExprNode;

ExprNode * make_expr_node(ExprNode *, ExprNode *, char *);
char * get_expr_lnode(ExprNode *);

#endif

