{
 open Parser
 exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
 | [' ' '\t'] { token lexbuf }
 | newline { Lexing.new_line lexbuf; token lexbuf }
 | ['a'-'z' 'A'-'Z' '0'-'9' '_' '\'']+ as word { if word == "let" then LET else IDENT(word) }
 | '(' {LPAREN}
 | ')' {RPAREN}
 | "(*" {comment 0 lexbuf}
 | "*)" {RCOMM}
 | '=' {EQUALS}
 | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
 | eof { EOF }

and comment level =  parse
 | "(" { comment (level + 1) lexbuf }
 | ")" { if level = 0 then token lexbuf else comment (level -1) lexbuf }
 | [' ' '\t'] { comment lexbuf }
 | _ { comment level lexbuf }