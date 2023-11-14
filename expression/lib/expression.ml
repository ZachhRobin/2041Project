include Ast
module Lexer = Lexer
module Parser = Parser 

let rec string_of_expression (e : expression) =
  match e with 
  | Identifier nm -> nm
  | Application (e1, e2) -> 
      "(" ^ (string_of_expression e1) ^ 
      " " ^ (string_of_expression e2) ^ ")"
