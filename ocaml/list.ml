(** working on lists *)

(** 1. get the last element list  *)

let rec last = function
    | [] -> None
    | [x] -> Some x
    | _ :: t -> last t;;

last ["a" ; "b" ; "c" ; "d"];;

last [];;

(** 2. get the last two elements list  *)


let rec last_two = function 
	| [] | [_] -> None
	| [x; y] -> Some (x,y)
    | _ :: t -> last_two t;;

last_two ["a"; "b"; "c"; "d"];;

(* 3. Find the K'th element of a list. (easy) *)
let rec at k = function
    | [] -> None
    | h :: t -> if k = 1 then Some t else at (k - 1) t;;


at 3 ["a"; "b"; "c"; "d"];;

(* 4. Find the number of elements of a list. (easy) *)

let rec length = function
    | [] -> 0
    | [_] -> 1
    | _ :: t -> 1 + length t;;

length [1;2;3;4;5];;

(* 5. Reverse a list. (easy) *)
let rev list =
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (h :: acc) t in
  aux [] list;;

rev [1;2;3;4];;


let rec myrev = function
  | [] -> []
  | h :: t -> myrev t @ [h];;
  
myrev [1;2;3];;

(* 6. Find out whether a list is a palindrome. (easy) *)
let is_palindrome list =
  (* One can use either the rev function from the previous problem, or the built-in List.rev *)
  list = List.rev list;;

is_palindrome [1;2;3;2;1]


type 'a node =
| One of 'a 
| Many of 'a node list;;

(* 7. Flatten a nested list structure. (medium) *)
let flatten list =  
  let rec aux acc  = function
  | [] -> acc
  | One x::t -> aux (x::acc) t
  | Many l::t -> aux (aux acc l) t in 
  aux [] list


(* 8. Eliminate consecutive duplicates of list elements. (medium) *)
let rec compress = function
    | a :: (b :: _ as t) -> if a = b then compress t else a :: compress t
    | smaller -> smaller;;

(* compress ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];; *)

let pack list =
  let rec aux current acc = function
    | [] -> []    (* Can only be reached if original list is empty *)
    | [x] -> (x :: current) :: acc
    | a :: (b :: _ as t) ->
       if a = b then aux (a :: current) acc t
       else aux [] ((a :: current) :: acc) t  in
  List.rev (aux [] [] list);;

  (* 10 Run-length encoding of a list. *)
  let encode list =
    let rec aux count acc = function
      | [] -> [] (* Can only be reached if original list is empty *)
      | [x] -> (count + 1, x) :: acc
      | a :: (b :: _ as t) -> if a = b then aux (count + 1) acc t
                              else aux 0 ((count + 1, a) :: acc) t in
    List.rev (aux 0 [] list);;

type 'a rle =
| One of 'a
| Many of int * 'a;;

(* 11 Modified run-length encoding. (easy) *)

let encode l = 
  let create_tuple cnt ele = 
    if cnt = 1 then One ele 
    else Many (cnt, ele) in 
  let rec aux count acc = function 
    | [] -> [] 
    | [x] -> (create_tuple (count + 1) x) :: acc
    | hd :: (snd :: _ as tl) ->
        if hd = snd then aux (count + 1) acc tl
        else aux 0 ((create_tuple (count + 1) hd) :: acc) tl in
      List.rev (aux 0 [] l)
encode ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];;

(* 12. Decode a run-length encoded list. (medium) *)


let decode l = 
  (* let create *)
  let rec many acc n x = 
    if n == 0 then acc else many (x::acc) (n-1) x
  in
  let rec aux acc = function
    | [] -> acc 
    | One x :: t -> aux (x::acc) t
    | Many (n, x) :: t -> aux (many acc n x) t
  in
    aux [] (List.rev list);;

decode [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d"; Many (4, "e")];;



(* 14. Duplicate the elements of a list. (easy) *)
let rec duplicate = function
  | [] -> []
  | h :: t -> h::h::duplicate t;;
duplicate ["a"; "b"; "c"; "c"; "d"];;

(* 15. Replicate the elements of a list a given number of times. (medium) *)
(* let replicate list n =
  let rec prepend n acc x =
    if n = 0 then acc else prepend (n-1) (x :: acc) x in
  let rec aux acc = function
    | [] -> acc
    | h :: t -> aux (prepend n acc h) t in
  (* This could also be written as:
     List.fold_left (prepend n) [] (List.rev list) *)
  aux [] (List.rev list);; *)


  (* 16. Drop every N'th element from a list. (medium) *)
let rec drop list n = 
  let rec aux i = function 
    | [] -> [] 
    | h :: t -> if i == n then aux 1 t else h :: aux (i + 1) t  in
    aux 1 list;;

drop ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 3;;

(* 17. Split a list into two parts; the length of the first part is given. (easy) *)
let split list n = 
  let rec aux i acc = function
    | [] -> List.rev acc, []
    | h :: t as l -> if i = 0 then List.rev acc, l
                      else aux (i - 1) (h :: acc) t 
  in
    aux n [] list;;

split ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 3;;


(* 18. Extract a slice from a list. (medium) *)
let slice list i k  =
  let rec drop n = function
  | [] -> []
  | h :: t as l -> if n = 0 then l else drop (n - 1) t
  in
  let rec take n = function
  | [] -> []
  | h :: t -> if n = 0 then [] else h :: take (n - 1) t
  in
  take (k - i + 1) (drop i list);;

slice ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 2 6;;


(* 19 Rotate a list N places to the left. (medium) *)
(* let rotate list n = 
  let rec aux i = function
  | [] -> []
  | h :: t -> if i < n then aux i+1 t@[h] else h::t in
  aux 1 list
rotate ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"] 3;; *)


(* 20. Remove the K'th element from a list. (easy) *)
let rec remove_at n = function
    | [] -> []
    | h :: t -> if n = 0 then t else h :: remove_at (n - 1) t;;
remove_at 1 ["a"; "b"; "c"; "d"];;


(* 21. Insert an element at a given position into a list. (easy) *)


insert_at "alfa" 1 ["a"; "b"; "c"; "d"];;

(* 22. Create a list containing all integers within a given range. (easy) *)

let rec range a b = 
  let rec aux a b =
    if a > b then [] else a :: aux (a + 1) b
  in
    if a > b then List.rev (aux b a) else aux a b;;

  if a < b then [a]::range a+1 b
  if b < a then [b]::range a b-1 
  if a == b then range a b

range 4 9;;
