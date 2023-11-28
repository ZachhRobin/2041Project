(* Our rewriter for code that is parsed *)
include Ast
include Declaration

module Parser = Parser 
module Lexer = Lexer

let parse_expression (s:string) : expression = 
  let lexbuf = Lexing.from_string s in 
  let ast = Parser.expression_eof
    Lexer.token lexbuf in ast

let get_lhs eq =
    Equality(e1 : expression, _) -> e1 
let get_rhs eq =
    Equality(e1 : equality, e2 : expression) -> e2

(* Matches expression with something it should be equal to  *)
let rec match_expression vars eq expr =
  match get_lhs eq with

let rec attempt_rewrites (vars: string list) (eq: Equality) (expr: Expression) : (Expression option) =
    

and rec attempt_rewrite (eq: equality) = 
    match eq with
    | Equality(e1: expression, e2 :expression) -> Some e1
    | LLinkedEq(e1, _) -> attempt_rewrite e1
    | _ -> None