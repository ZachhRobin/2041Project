(* Abstract Syntax Tree. Define all types needed here, options inside datatypes that hold data *)

type expression =
  | Identifier of string
  | Application of expression * expression
  | Oftype of expression * expression

type declaration =
  |Let of equality
  |Letprove of equality
  |Prove of equality
  | Axiom of declaration

and equality = 
  |Equality of expression * expression
  |LLinkedEq of equality * expression
  |RLinkedEq of expression * equality

(* and hint = 
  | Axiom of declaration
  | Induction of string
  | Direct *)
