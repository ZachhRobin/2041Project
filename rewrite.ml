(* Our rewriter for code that is parsed *)
include Ast
include Declaration

module Parser = parser 
module Lexer = lexer

let parse_expression (s:string) : expression = 
  let lexbuf = Lexing.from_string s in 
  let ast = Parser.expression_eof
    Lexer.token lexbuf in ast

(* Our module for creating substitutions on a given string *)
module Substitution = struct
  module MM = Map.Make(String) (*String might not be capital, try changing*)
  type t = expression MM.t (*Probably mapping a function on to an expression*)
  exception SubstitutionFailed (*Throws an error if substitution does not work!*)
  
  let print_subst (s : t) = 
    MM.iter (fun k v -> print_endline (k ^ " -> " ^ string_of_expression v))
  (* Idk what these are *)
  let empty =
  let singleton =
  let merge =
  let find =
  
  (* Matches expression with something it should be equal to  *)
  let rec match_expression

  (* Applies substitution to matched expression *)
  let rec substitute 


end

(* Probably prints the rewritten stuff idk *)
let rec attempt_rewrites 

and attempt_rewrite
