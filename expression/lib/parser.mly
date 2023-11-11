%{
    open Ast
%}


%token <string> IDENT
%token LPAREN
%token RPAREN
%token EOF
%start main
%type <expression list> main
%%
main:
| e = expression ; EOF { [e] }
expression:
| nm = IDENT { Identifier nm }