include Ast
include Expression
module Lexer = Lexer
module Parser = Parser 

let rec string_of_equality (eq: equality) = match eq with 
  |Equality (e1,e2) -> string_of_expression e1 ^" = "^string_of_expression e2
  |LLinkedEq (eq, e) -> string_of_equality eq ^ " = " ^ string_of_expression e
  |RLinkedEq (e, eq) -> string_of_expression e ^ " = " ^ string_of_equality eq

let string_of_declaration (d : declaration) =
  match d with
  | Let (eq) -> "let " ^ string_of_equality eq
  | Prove (d) -> " (*prove*) " ^ string_of_equality d
  | Letprove (eq) -> "let (*prove*) " ^ string_of_equality eq