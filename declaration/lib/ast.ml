type expression =
  | Identifier of string
  | Application of expression * expression

type declaration =
  |Let of equality
  |Letprove of equality
  |Prove of equality

and equality = Equality of expression * expression

type arguments = (string * string) list

and hint = 
  | Axiom
  | Induction of string
  | Direct
