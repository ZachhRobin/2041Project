%token <string> WORD
%token <string> COMMENT
%token <string> AXIOM
%token EOF
%token <int> what
%start main
%type <string list> main
%%
main:
| line EOF { $1 }
line:
| { [] }
| WORD line { $1 :: $2 }
