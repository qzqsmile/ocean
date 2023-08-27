type 'a binary_tree =
    | Empty
    | Node of 'a * 'a binary_tree * 'a binary_tree;;


(* 56. Symmetric binary trees. (medium) *)
let rec is_mirror t1 t2 = 
  match t1, t2 with
  | pattern -> pattern
  | Node(_, l1, r1), Node(_, l2, r2) ->
    is_mirror l1 r2 && is_mirror r1 l2
  | _ -> false

let is_symmetric = function
  | Empty -> true
  | Node(_, l, r) -> is_mirror l r;;


(* 57. Binary search trees (dictionaries). (medium) *)
let rec insert tree x = match tree with
  | Empty -> Node (x, Empty, Empty)
  | Node (y, l, r) ->
     if x = y then tree
     else if x < y then Node (y, insert l x, r)
     else Node (y, l, insert r x)
let construct l = List.fold_left insert Empty l;;


(* 58. Generate-and-test paradigm. (medium) *)
let sym_cbal_trees n =
  List.filter is_symmetric (cbal_tree n);;