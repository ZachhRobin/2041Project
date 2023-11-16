include Ast
module Lexer = Lexer
module Parser = Parser 

let rec string_of_expression (e : expression) =
  match e with 
  | Identifier nm -> nm
  | Application (e1, e2) -> 
      (string_of_expression e1) ^ 
      " " ^ (string_of_expression_with_parens e2) 
and string_of_expression_with_parens e = match e with
    |Identifier nm -> nm
    |Application _ -> "("^string_of_expression e ^")"

and string_of_equality e = match e with
  |Equality (e1, e2) -> (string_of_expression e1) ^ " = " ^ (string_of_expression e2)