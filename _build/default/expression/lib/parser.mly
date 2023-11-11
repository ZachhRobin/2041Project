%token <string> IDENT
%token LPAREN
%token RPAREN
%token EOF
%start main
%type <string list> main
%%
main:
| line EOF { $1 }
line:
| { [] }
| WORD line { $1 :: $2 }
