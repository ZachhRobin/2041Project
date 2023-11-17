type expression =
  | Identifier of string
  | Application of expression * expression
  | Equality of expression * expression
  | Cons of expression * expression
  | Let of expression
  | Prove of expression

(*and equality = Equality of expression * expression*)
type arguments = (string * string) list

type declaration =
  |Letprove of string * arguments * expression
  |Letrecprove of string * arguments * expression
  |Prove of expression

and hint = 
  | Axiom
  | Induction of string
  | Direct
