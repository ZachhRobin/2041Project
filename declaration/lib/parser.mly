%{
    open Ast
%}

// Pulls all tokens from the lexer. If something is added to the lexer it should be added here.
%token <string> IDENT
%token LCOMM
%token RCOMM
%token LPAREN
%token RPAREN
%token LET
%token EOF
%token EQUALS
%token OFTYPE
%token AXIOM
%token PROVE
// This declares main as something that should run

%start main

//Along with main, this is where to define all of our created types created in the AST.
%type <declaration list> main
%type <equality> equality
%type <expression> expression
%type <declaration> declaration
%%

// This is our main rule. It's what holds the entire string as a list of declarations
main:
| d = list(declaration) ; EOF { d }

//Our declaration rule. This is how the parser knows what AST type each declaration should be read as
declaration:
|LET; PROVE; eq = equality {Letprove eq}
| d = declaration; AXIOM { Axiom (d) }
|LET; e = equality {Let e}
|PROVE; eq = equality {Prove eq}

//Our expression rule. This is how the parser knows what AST type each expression should be read as
expression:
| LPAREN ; e = expression ; RPAREN { e }
| nm = IDENT { Identifier nm }
| e1 = expression; OFTYPE; e2 = expression {Oftype (e1,e2)}
|LCOMM; txt = IDENT; RCOMM; {Identifier txt}
|e1 = expression; nm = IDENT {Application (e1,Identifier nm) }
|e1 = expression; LPAREN; e2 = expression ; RPAREN {Application (e1, e2) }


//Our equality rule. This is how the parser knows what AST type each equality should be read as. Equality of (expression*expression) or (equality*expression) or (expression*equality)
equality:
|e1 = expression; EQUALS; e2 = expression {Equality (e1, e2)}
|eq = equality; EQUALS; e = expression {LLinkedEq (eq, e)}
|e = expression; EQUALS; eq = equality {RLinkedEq (e, eq)}
|LPAREN; eq = equality; RPAREN { eq }
