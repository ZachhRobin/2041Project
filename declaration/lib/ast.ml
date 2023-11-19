type expression =
  | Identifier of string
  | Application of expression * expression
  | Oftype of expression * expression

type declaration =
  |Let of equality
  |Letprove of equality
  |Prove of equality

and equality = 
  |Equality of expression * expression
  |LLinkedEq of equality * expression
  |RLinkedEq of expression * equality

type arguments = (string * string) list

and hint = 
  | Axiom
  | Induction of string
  | Direct
