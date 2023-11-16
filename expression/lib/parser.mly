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
%start main
%type <expression list> main
%type <expression> expression
%%
main:
| e = expression ; EOF { [e] }
expression:
| LPAREN ; e = expression ; RPAREN { e }
| nm = IDENT { Identifier nm }
|LCOMM; txt = IDENT; RCOMM; {Identifier txt}
|e1 = expression; nm = IDENT {Application (e1,Identifier nm) }
|e1 = expression; LPAREN; e2 = expression ; RPAREN {Application (e1, e2) }
|e1 = expression; EQUALS; e2 = expression {Equality (e1, e2)}

