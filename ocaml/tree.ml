type 'a binary_tree =
| Empty
| Node of 'a * 'a binary_tree * 'a binary_tree;;


(* let add_trees_with left right all =
  let add_right_tree all l =
    List.fold_left (fun a r -> Node ('x', l, r) :: a) all right in
  List.fold_left add_right_tree all left

let rec cbal_tree n =
  if n = 0 then [Empty]
  else if n mod 2 = 1 then
    let t = cbal_tree (n / 2) in
    add_trees_with t t []
  else (* n even: n-1 nodes for the left & right subtrees altogether. *)
    let t1 = cbal_tree (n / 2 - 1) in
    let t2 = cbal_tree (n / 2) in
    add_trees_with t1 t2 (add_trees_with t2 t1 []);; *)


let rec is_mirror l r = 
  match l, r with 
  | Empty, Empty -> true 
  | Node(_, l1, r1), Node(_, l2, r2) ->
    is_mirror l1 r2 && is_mirror r1 l2
  | _ -> false 


let is_symmetric = function
  | Empty -> true
  | Node(_, l, r) -> is_mirror l r;;

  (* construct [3; 2; 5; 7; 1];; *)

let construct list = 
  let rec insert x acc = 
    match acc with 
    | Empty -> Node(x, Empty, Empty)
    | Node(v, l, r) -> 
      if v < x then Node(v, l, insert x r)  
      else Node(v, insert x l, r)  in
  let rec aux  acc = function
  | [] -> acc 
  | [x] -> insert x acc 
  | h::t -> aux (insert h acc) t in 
  aux Empty list;;

  (* let sym_cbal_trees n =
    List.filter is_symmetric (cbal_tree n);; *)

(* let rec hbal_tree n =
  if n = 0 then [Empty]
  else if n = 1 then [Node ('x', Empty, Empty)]
  else
  (* [add_trees_with left right trees] is defined in a question above. *)
    let t1 = hbal_tree (n - 1)
    and t2 = hbal_tree (n - 2) in
    add_trees_with t1 t1 (add_trees_with t1 t2 (add_trees_with t2 t1 []));; *)
    let max_nodes h = 1 lsl h - 1;;

(* count_leaves Empty;; *)
(* let rec count_leaves = function 
| Empty->0
| Node(_, Empty, Empty)-> 1 
| Node(_, l, r) -> 
  1 + count_leaves l + count_leaves r;; *)

(* leaves Empty;; *)

(* let rec leaves Empty;; *)
(* let leaves root = 
  let rec aux acc = function 
  | Empty -> acc 
  | Node(x, Empty, Empty)->
     Node(x,Empty, Empty)::acc 
  | Node(x, l, r)->
    aux (aux acc l) r in 
    aux [] root;;  *)

(* internals (Node ('a', Empty, Empty));; *)
(* let internals root = 
  let rec aux acc = function 
  | Empty -> acc 
  | Node(_, Empty, Empty) -> acc  
  | Node(x, l, r) -> 
    aux (Node(x,l,r)::(aux acc l)) r in 
  aux [] root;; *)


  (* Collect the Nodes at a Given Level in a List *)
(* Beginner *)
(* let example_tree =
  Node ('a', Node ('b', Node ('d', Empty, Empty), Node ('e', Empty, Empty)),
       Node ('c', Empty, Node ('f', Node ('g', Empty, Empty), Empty)));;
val example_tree : char binary_tree =
  Node ('a', Node ('b', Node ('d', Empty, Empty), Node ('e', Empty, Empty)),
   Node ('c', Empty, Node ('f', Node ('g', Empty, Empty), Empty))) *)
let at_level example_tree level = 
  let rec aux cur acc = function
  | Empty -> acc
  | Node(x, l, r) -> 
    if cur = level then (x::acc) 
    else aux (cur+1) (aux (cur+1) acc l) r in 
    aux 1 [] example_tree;;

    (* Construct a Complete Binary Tree *)