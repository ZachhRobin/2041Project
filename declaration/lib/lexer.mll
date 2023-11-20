{
 open Parser
 exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"
(* List of how each character or string in a file fed should be interpreted. If we are getting syntax error of unknown char 'x' the probem is likely here *)
rule token = parse
 | [' ' '\t'] { token lexbuf }
 | newline { Lexing.new_line lexbuf; token lexbuf } 
 | "(*prove*)" {PROVE}
 | "(*hint: axiom *)" {AXIOM} 
 | ['a'-'z' 'A'-'Z' '0'-'9' '_' '\'']+ as word { 
    match word with 
        |"let" -> LET
        |_ -> IDENT (word)
  }
 | '(' {LPAREN}
 | ')' {RPAREN}
 | "(*" {comment 0 lexbuf}
 | "*)" {RCOMM}
 | ":" {OFTYPE} 
 | '=' {EQUALS}
 | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
 | eof { EOF }

(* Rule for how to handle and ignore comments. Taken from lecture slides. Somehow we are supposed to allow it to interpret newlines only. Do that later please *)
and comment level =  parse
 | "(*" { comment (level + 1) lexbuf }
 | "*)" { if level = 0 then token lexbuf else comment (level -1) lexbuf }
 | _ { comment level lexbuf }
 | eof {raise (SyntaxError "Unclosed comment")}