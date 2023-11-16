include Ast
module Lexer = Lexer
module Parser = Parser 

let rec string_of_expression (e : expression) =
  match e with 
  | Identifier nm -> nm
  | Cons (e1, e2) -> string_of_expression e1^ " : " ^ string_of_expression e2
  | Equality (e1,e2) -> string_of_expression e1^" = "^string_of_expression e2
  | Let e -> "let " ^ string_of_expression e
  | Application (e1, e2) -> 
      (string_of_expression e1) ^ 
      " " ^ (string_of_expression_with_parens e2) 
and string_of_expression_with_parens e = match e with
    |Identifier nm -> nm
    |Application _ -> "("^string_of_expression e ^")"
    |Equality (_,_) -> "("^string_of_expression e ^ ")"
    |Cons (_, _) -> "("^string_of_expression e ^ ")"
    |Let (_) -> "(" ^ string_of_expression e ^ ")"