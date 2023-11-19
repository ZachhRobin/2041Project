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
%token OFTYPE
%token PROVE
%start main
%type <declaration list> main
%type <equality> equality
%type <expression> expression
%type <declaration> declaration
%%
main:
| d = list(declaration) ; EOF { d }
declaration:
|LET; PROVE; eq = equality {Letprove eq}
|LET; e = equality {Let e}
|PROVE; eq = equality {Prove eq}
expression:
| LPAREN ; e = expression ; RPAREN { e }
| nm = IDENT { Identifier nm }
| e1 = expression; OFTYPE; e2 = expression {Oftype (e1,e2)}
|LCOMM; txt = IDENT; RCOMM; {Identifier txt}
|e1 = expression; nm = IDENT {Application (e1,Identifier nm) }
|e1 = expression; LPAREN; e2 = expression ; RPAREN {Application (e1, e2) }
// |e1 = expression; EQUALS; e2 = expression { (e1, e2)}
equality:
|e1 = expression; EQUALS; e2 = expression {Equality (e1, e2)}
|eq = equality; EQUALS; e = expression {LLinkedEq (eq, e)}
|e = expression; EQUALS; eq = equality {RLinkedEq (e, eq)}
|LPAREN; eq = equality; RPAREN { eq }
