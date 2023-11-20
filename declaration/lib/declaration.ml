include Ast
include Expression
module Lexer = Lexer
module Parser = Parser 

(* Creates a string for type equality.. Technically shouldn't be here but for simplicity sake it is *)
let rec string_of_equality (eq: equality) = 
  match eq with 
  | Equality (e1,e2) -> string_of_expression e1 ^" = "^string_of_expression e2
  | LLinkedEq (eq, e) -> string_of_equality eq ^ " = " ^ string_of_expression e
  | RLinkedEq (e, eq) -> string_of_expression e ^ " = " ^ string_of_equality eq

(* Creates a string for type declaration. New match statement must be written for each type of declaration.
   
CHANGE: Hints should be introduced as own type eventually. Here for simplicity sake *)

let rec string_of_declaration (d : declaration) =
  match d with
  | Let (eq) -> "let " ^ string_of_equality eq
  | Prove (d) -> " (*prove*) " ^ string_of_equality d
  | Letprove (eq) -> "let (*prove*) " ^ string_of_equality eq
  | Axiom (d) -> string_of_declaration d ^ "\n(*hint: axiom*)"
(* MAKE THIS LATER v *)
(* let string_of_hint (h : hint ) = 
  match h with
  |Axiom (d) -> string_of_declaration d ^ "\n(*hint: axiom*) " *)