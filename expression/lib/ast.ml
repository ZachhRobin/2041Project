type expression =
  | Identifier of ident
  | String of string
  | Number of int
  | Application of expression * expression

and statement =
  | Declaration of ident * expression
  | Assignment of ident * expression
  | If_Else of expression * statement list * statement list 

and hint = 
  | Axiom
  | Induction of string
  | Direct

  and ident = string
