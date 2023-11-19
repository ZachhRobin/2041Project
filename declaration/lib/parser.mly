%{
    open Ast
%}

%token <string> IDENT
%token LCOMM
%token RCOMM
%token LPAREN
%token RPAREN
%token LET
%token EOF
%token EQUALS
// %token CONS
%token PROVE
%start main
%type <declaration list> main
%type <equality> equality
%type <expression> expression
%type <declaration> declaration
%%
main:
| d = declaration ; EOF { [d] }
declaration:
|LET; e = equality {Let e}
|PROVE; d = declaration {Prove d}
expression:
| LPAREN ; e = expression ; RPAREN { e }
| nm = IDENT { Identifier nm }
|LCOMM; txt = IDENT; RCOMM; {Identifier txt}
|e1 = expression; nm = IDENT {Application (e1,Identifier nm) }
|e1 = expression; LPAREN; e2 = expression ; RPAREN {Application (e1, e2) }
equality:
|e1 = declaration; EQUALS; e2 = expression {Equality (e1, e2)}
