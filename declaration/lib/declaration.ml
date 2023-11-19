include Ast
include Expression
module Lexer = Lexer
module Parser = Parser 

let string_of_equality (eq: equality) = string_of_declaration e1^" = "^string_of_expression e2

let rec string_of_declaration (d : declaration) =
  match d with
  | Equality (e1,e2) -> string_of_declaration e1^" = "^string_of_expression e2
  | Let (eq) -> "let " ^ string_of_equality e
  | Prove (d) -> " (*prove*) " ^ string_of_declaration d
  | Letprove (eq) -> "let (*prove*) " ^ string_of_equality e