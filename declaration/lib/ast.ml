type expression =
  | Identifier of string
  | Application of expression * expression

type declaration =
  |Let of equality
  (* |Equality of declaration * expression *)
  |Prove of declaration

and equality = Equality of declaration * expression

type arguments = (string * string) list

and hint = 
  | Axiom
  | Induction of string
  | Direct
