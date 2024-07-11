type 'a node =
| Empty 
| Node of 'a * 'a node;;

let node  = Node(1, Node(2, Empty));;

let collect node = 
  let rec aux acc = function 
  | Empty -> acc 
  | Node(x, r) -> 
    aux (x::acc) r in 
    List.rev (aux [] node);;

collect node;;



(* type 'a node =
  | Empty
  | Node of 'a * 'a node;; *)
