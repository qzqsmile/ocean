(* Truth Tables for Logical Expressions (2 Variables) Intermediate*)

type bool_expr =
  | Var of string
  | Not of bool_expr
  | And of bool_expr * bool_expr
  | Or of bool_expr * bool_expr;;

let rec eval2 a val_a b val_b = function
    | Var x -> if x = a then val_a
               else if x = b then val_b
               else failwith "The expression contains an invalid variable"
    | Not e -> not (eval2 a val_a b val_b e)
    | And(e1, e2) -> eval2 a val_a b val_b e1 && eval2 a val_a b val_b e2
    | Or(e1, e2) -> eval2 a val_a b val_b e1 || eval2 a val_a b val_b e2

let table2 a b expr =
  [(true,  true,  eval2 a true  b true  expr);
   (true,  false, eval2 a true  b false expr);
   (false, true,  eval2 a false b true  expr);
   (false, false, eval2 a false b false expr)];;

table2 "a" "b" (And (Var "a", Or (Var "a", Var "b")));;



(* table ["a"; "b"] (And (Var "a", Or (Var "a", Var "b")));; *)
let rec eval val_vars = function
| Var x -> List.assoc x val_vars
| Not e -> not (eval val_vars e)
| And(e1, e2) -> eval val_vars e1 && eval val_vars e2
| Or(e1, e2) -> eval val_vars e1 || eval val_vars e2

let rec table_make val_vars vars expr =
  match vars with
  | [] -> [(List.rev val_vars, eval val_vars expr)]
  | v :: tl ->
       table_make ((v, true) :: val_vars) tl expr
     @ table_make ((v, false) :: val_vars) tl expr

let table vars expr = table_make [] vars expr;;

(* Gray Code Intermediate *)

let add list = 
  let rec add cur acc = function 
    | []-> acc
    | h::t  -> add cur ((cur^h)::acc) t
    in add "0" [] list @ add "1" [] list;;


    (* @ (add "1" ((cur^h)::acc) t)  *)

let gay n = 
 let rec aux cur acc =  
  if cur > n then acc 
  else aux (cur+1) acc

