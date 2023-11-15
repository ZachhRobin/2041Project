type expression =
  | Identifier of string
  | Number of int
  | Application of expression * expression

and statement =
  | Declaration of ident * expression
  | Assignment of ident * expression

and ident = string