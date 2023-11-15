type expression =
  | Identifier of ident
  | String of string
  | Number of int
  | Application of expression * expression

type ident = string
type equality = expression * expression
type arguments = (string * string) list

type declaration =
  |Letprove of string * arguments * expression
  |Letrecprove of string * arguments * expression

and statement =
  | Declaration of ident * expression
  | Assignment of ident * expression
  | If_Else of expression * statement list * statement list 

and hint = 
  | Axiom
  | Induction of string
  | Direct