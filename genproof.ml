include Ast

module Parser = Parser
module Lexer = Lexer

let parse (s : string) : expression =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.expression_eof Lexer.token lexbuf in
     ast

let string_of_declaration = String_of.string_of_declaration

let empty = []
let singleton x y = [(x,y)]
let merge s1 s2 = match s1 with
  | [] -> Some s2 (* this case is actually correct, but it shouldn't be needed once the other one is fixed *)
  | _ -> if s2 = [] then Some s1 else if Some s1 = Some s2 then Some s1 else failwith "non-empty"


  (* check if both are empty, check if s1 is empty, check if non-empty and equal, if not equal raise error, if equal return some*)

let rec match_expression variables pattern expression =
  match pattern with
    | Identifier x -> if x = "x" then (* Todo: fix test for variables: the string "x" is not necessarily the only variable and it might not always be a variable either *)
        (* if x is a variable: *)
        Some (singleton x expression)
        else
        (* if x is a constant: *)
        (if pattern = expression then Some empty else None)
    | Application (p1, p2) -> (* x has to be an application too, otherwise return None *)
        (match expression with
            | Application (e1, e2) ->
                (* We recursively match the sub-expressions.
                    This part is much easier to write if e2 is an expression (and it is for this particular ast),
                    because it's so symmetrical *)
                (match match_expression variables p1 e1, match_expression variables p2 e2 with
                | Some s1, Some s2 -> merge s2 s1
                | _ -> None)
            | _ -> None)
    | _ -> None


let find x s = match s with
  | [] -> failwith "Not found (find was passed an empty list)"
  | [(k,v)] -> if x = k then v else failwith "Not found (find failed but the substitution being passed in really does not contain the variable)"
  | _ -> failwith "Find failed (key not found because this part of the find function is utterly broken)"

let rec substitute variables s e = match e with
    | Identifier "x" -> find "x" s
    | Application (e1, e2) -> Application (substitute variables s e1, substitute variables s e2)
    | _ -> e

let rec attempt_rewrite variables lhs rhs expression =
  match match_expression variables lhs expression with
    | Some s -> Some (substitute variables s rhs)
    | None -> (match expression with
        | Application (e1, e2) -> (match attempt_rewrite variables lhs rhs e2 with
            | None -> None (* todo: try the other side too! *)
            | Some e2' -> Some (Application (e1, e2')))
        | _ -> None (* not succesful *)
        )

let rec perform_step rules expression = match rules with
  | (variables, nm, lhs, rhs) :: _ :: rest -> (match attempt_rewrite variables lhs rhs expression with
      | Some e -> Some (nm, e)
      | _ -> perform_step rest expression)
  | _ -> None

let rec perform_steps rules expression = match perform_step rules expression with
  | Some (nm, e) -> (nm, e) :: perform_steps [] e
  | None -> []
  
  let rec prove rules lhs rhs
  = String_of.string_of_expression lhs :: 
    (match perform_steps rules lhs with
     | (nm, e) :: _ -> (" = { " ^ nm ^ " }") :: prove rules e rhs
     | [] -> if lhs = rhs then [] else " = { ??? }" :: [String_of.string_of_expression rhs])
     
     let rec prover rules declarations =
      match declarations with
         | ProofDeclaration (nm, vars, Equality (lhs,rhs), None) :: rest
            -> (* no hint, so let's prove this *)
               prove rules lhs rhs :: prover ((vars,nm,lhs,rhs)::rules) rest
         | ProofDeclaration (nm, vars, Equality (lhs,rhs), _) :: rest
            -> (* we got a hint so we simply assume the statement *)
               prover ((vars,nm,lhs,rhs)::rules) rest
         | _ :: rest -> prover rules rest
         | [] -> []
   let prover_main decls =
      prover [] decls |>
      List.map (String.concat "\n") |>
      String.concat "\n\n" |>
      print_endline