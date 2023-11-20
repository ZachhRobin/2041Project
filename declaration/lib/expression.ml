include Ast
module Lexer = Lexer
module Parser = Parser 

let rec string_of_expression (e : expression) =
  match e with 
  | Identifier nm -> nm
  | Oftype (e1,e2) -> string_of_expression e1 ^" : " ^ string_of_expression e2
  | Application (e1, e2) -> 
      (string_of_expression e1) ^ 
      " " ^ (string_of_expression_with_parens e2) 
and string_of_expression_with_parens e = match e with
    |Identifier nm -> nm
    |_ -> "("^string_of_expression e ^")"