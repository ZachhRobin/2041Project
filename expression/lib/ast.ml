type expression =
  | Identifier of string
  | Application of expression * expression

type equality = Equality of expression * expression
type arguments = (string * string) list

type declaration =
  |Letprove of string * arguments * expression
  |Letrecprove of string * arguments * expression

and hint = 
  | Axiom
  | Induction of string
  | Direct
