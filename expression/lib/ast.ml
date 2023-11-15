type expression =
  | Identifier of string
  | Application of expression * expression

type hint =
  |Axiom
  |Induction of string
  |Direct