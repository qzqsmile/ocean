(** working on lists *)

(** get the last element list  *)

let rec last = function
    | [] -> None
    | [x] -> Some x
    | _ :: t -> last t;;

last ["a" ; "b" ; "c" ; "d"];;

last [];;

(** get the last two elements list  *)


let rec last_two = function 
	| [] | [_] -> None
	| [x; y] -> Some (x,y)
    | _ :: t -> last_two t;;

last_two ["a"; "b"; "c"; "d"];;


let rec at k = function
    | [] -> None
    | h :: t -> if k = 1 then Some t else at (k - 1) t;;


at 3 ["a"; "b"; "c"; "d"];;

(* Find the number of elements of a list. (easy) *)

let rec length = function
    | [] -> 0
    | [_] -> 1
    | _ :: t -> 1 + length t;;

length [1;2;3;4;5];;

(* Reverse a list. (easy) *)


let rev list =
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (h :: acc) t in
  aux [] list;;

let reverse_list lst =
  let rec aux acc = function
    | [] -> lst
    | hd :: tl -> aux (hd :: acc) tl in
  aux [] lst;;

reverse_list [1;2;3;4];;


let is_palindrome list =
  (* One can use either the rev function from the previous problem, or the built-in List.rev *)
  list = List.rev list;;

is_palindrome [1;2;3;2;1]


let pack list =
  let rec aux current acc = function
    | [] -> []    (* Can only be reached if original list is empty *)
    | [x] -> (x :: current) :: acc
    | a :: (b :: _ as t) ->
       if a = b then aux (a :: current) acc t
       else aux [] ((a :: current) :: acc) t  in
  List.rev (aux [] [] list);;


  (* Run-length encoding of a list. *)
  let encode list =
    let rec aux count acc = function
      | [] -> [] (* Can only be reached if original list is empty *)
      | [x] -> (count + 1, x) :: acc
      | a :: (b :: _ as t) -> if a = b then aux (count + 1) acc t
                              else aux 0 ((count + 1, a) :: acc) t in
    List.rev (aux 0 [] list);;


(* Duplicate the elements of a list. (easy) *)
let duplicate = function
      | [] -> []
      | [h :: t] -> h :: h :: duplicate t;;

duplicate ["a"; "b"; "c"; "c"; "d"];;

(* . Replicate the elements of a list a given number of times. *)

let duplciate count = function
     | [] -> []
     | h :: t -> if count == 1 then h :: duplciate count t
                 else 

(* Remove the K'th element from a list. (easy) *)
rec remove_at n = function
  | [] -> []
  | h :: t -> if n == 0 then t else h :: remove_at (n-1) t;;