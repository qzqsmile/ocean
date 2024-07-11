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


(* Flatten a list *)
(* flatten [One "a"; Many [One "b"; Many [One "c" ;One "d"]; One "e"]];; *)
(* type 'a node =
  | One of 'a node
  | Many of 'a node list *)

(* let flatten list =
    let rec aux acc = function
      | [] -> acc
      | One x :: t -> aux (x :: acc) t
      | Many l :: t -> aux (aux acc l) t
    in
    List.rev (aux [] list);; *)



(* # compress ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];; *)
let compress list = 
  let rec aux acc = function 
  | [] -> acc
  | [x] -> x :: acc 
  | a :: (b :: _ as t) ->
    if a = b then aux acc t
    else aux (a::acc) t in 
  List.rev (aux [] list);;







let pack list =
  let rec aux current acc = function
    | [] -> []    (* Can only be reached if original list is empty *)
    | [x] -> (x :: current) :: acc
    | a :: (b :: _ as t) ->
       if a = b then aux (a :: current) acc t
       else aux [] ((a :: current) :: acc) t  in
  List.rev (aux [] [] list);;

(* let  pack  current acc = function 
  | [] -> []    (* Can only be reached if original list is empty *)
  | [x] -> (x :: current) :: acc
  | a :: (b :: _ as t) ->
    if a = b then pack (a :: current) acc t
    else pack [] ((a :: current) :: acc) t;; *)


(* encode ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];; *)
(* [(4, "a"); (1, "b"); (2, "c"); (2, "a"); (1, "d"); (4, "e")] *)
(* let encode list  = 
    let rec aux current acc = function 
    | [] -> []
    | [x] -> (current, x) :: acc
    | h1 :: (h2 :: t) ->
      if h1 = h2 then aux (current+1) acc (h2::t)
      else aux 1 ((current+1, h1)::acc) t;; *)


(* pack ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "d"; "e"; "e"; "e"; "e"];; *)
(* [["a"; "a"; "a"; "a"]; ["b"]; ["c"; "c"]; ["a"; "a"]; ["d"; "d"];
 ["e"; "e"; "e"; "e"]] *)



  (* Run-length encoding of a list. *)
  (* encode ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];; *)
  (* let encode list =
    let rec aux count acc = function
      | [] -> [] (* Can only be reached if original list is empty *)
      | [x] -> (count + 1, x) :: acc
      | a :: (b :: _ as t) -> if a = b then aux (count + 1) acc t
                              else aux 0 ((count + 1, a) :: acc) t in
    List.rev (aux 0 [] list);;  *)


(* Modified Run-Length Encodin *)
(* encode ["a"; "a"; "a"; "a"; "b"; "c"; "c"; "a"; "a"; "d"; "e"; "e"; "e"; "e"];; *)
type 'a rle =
  | One of 'a
  | Many of int * 'a 
(* 
let encode list =
    let create count v = 
      if count = 1 then One v else Many(count, v)
    in
    let rec aux count acc = function
      | [] -> [] (* Can only be reached if original list is empty *)
      | [x] -> (create (count+1) x) :: acc
      | a :: (b :: _ as t) -> if a = b then aux (count + 1) acc t
                              else aux 0 (create (count+1) a :: acc) t in
    List.rev (aux 0 [] list);; *)

(* decode [Many (4, "a"); One "b"; Many (2, "c"); Many (2, "a"); One "d"; Many (4, "e")];; *)

(* let decode list = 
  let rec many count v acc =
    match count with 
    | 0 -> acc 
    | _ -> many (count-1) v (v::acc) 
  in 
  let rec aux acc = function 
  | []->acc
  | One h :: t -> aux (h::acc) t
  (* | Many (n, x) :: t -> aux (many acc n x) t *)
  | Many (n, x) :: t -> aux ((many n x [])@acc) t
  (* | Many (n, x) :: t -> aux (many n x [])@acc t *)
in List.rev (aux [] list) *)

(* Run-Length Encoding of a List (Direct Solution) *)
(* todo *)



(* Duplicate the elements of a list. (easy) *)
(* let duplicate = function
      | [] -> []
      | [h :: t] -> h :: h :: duplicate t;;

duplicate ["a"; "b"; "c"; "c"; "d"];; *)

(* . Replicate the elements of a list a given number of times. *)

(* let duplciate count = function
     | [] -> []
     | h :: t -> if count == 1 then h :: duplciate count t *)

(* Replicate the Elements of a List a Given Number of Times *)
(* replicate ["a"; "b"; "c"] 3;; *)
(* let replicate list count= 
  let rec duplicate count v acc = 
    if count == 0 then acc 
    else duplicate (count-1) v (v::acc)
  in 
  let rec aux count acc = function
  | [] -> []
  | [x] -> duplicate count x acc
  | h::t -> aux count (duplicate count h acc) t
in List.rev (aux count [] list) *)

(* Drop Every N'th Element From a List *)
(* drop ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 3;; *)
(* let drop list count = 
  let rec aux  cur acc = function 
  | []->acc 
  | h::t-> if cur = 1 then aux  count acc t 
  else aux (cur-1) (h::acc) t 
in List.rev (aux count [] list) *)
  

(* let split list n =
  let rec aux i acc = function
    | [] -> List.rev acc, []
    | h :: t as l -> if i = 0 then List.rev acc, l
                     else aux (i - 1) (h :: acc) t 
  in
    aux n [] list;; *)

(* Extract a Slice From a List Interme *)
(* slice ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"; "i"; "j"] 2 6;; *)
(* let slice s a b = 
  let rec aux count acc = function 
  | [] -> []
  | h :: t -> if count <= a then aux (count+1) acc t
  else if count > b then acc 
  else aux (count+1) (h::acc) t in 
  List.rev (aux 1 [] s);; *)

(* Rotate a List N Places to the Left Intermediate *)
(* rotate ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"] 3;; *)
(* let rotate list count = 
  let rec aux cur acc = function
  | []->[]
  | h::t as l -> 
    if cur = 0 then (l @ (List.rev acc))
    else aux (cur-1) (h::acc) t in 
    aux count [] list;; *)


(* Remove the K'th Element From a List Beginner *)

(* remove_at 1 ["a"; "b"; "c"; "d"];; *)

(* let remove_at count list = 
  let rec aux cur acc = function 
  | []->[]
  | h::t  -> 
    if cur = 1 then (List.rev acc) @ t 
    else aux (cur-1) (h::acc) t in 
    aux count [] list  *)

(* Insert an Element at a Given Position Into a List Beginner *)
(* insert_at "alfa" 1 ["a"; "b"; "c"; "d"];; *)
(* let rec insert_at str count list = 
  let rec aux cur acc = function 
  | []->[str]
  | h::t as l -> 
    if cur = 0 then (List.rev acc)  @ (str::l)
    else aux (cur-1) (h::acc) t 
  in aux count [] list  *)


  (* Create a List Containing All Integers Within a Given Range *)

(* let range b e = 
  let rec aux cur acc = 
    if cur >= b then if cur <= e then aux (cur+1) (cur::acc) else acc else []
    in List.rev (aux b []);; *)


(* Extract a Given Number of Randomly Selected Elements From a List Intermediate *)
(* rand_select ["a"; "b"; "c"; "d"; "e"; "f"; "g"; "h"] 3;; *)
let rand_select list n = 
  Random.self_init ();
  (* Random.init 0; *)
  let rec extract k acc= function 
  | [] -> []
  | h::t  -> 
    if k  = 0 then (List.rev acc) @ t 
    else extract (k-1) (h::acc) t
  in 
  let rec extract_n k acc = 
    if k > 0 then extract_n (k-1) (extract (Random.int (List.length acc)) [] acc)
    else acc 
  in extract_n (List.length list - n) list;;


  (* Lotto: Draw N Different Random Numbers From the Set 1..M *)
  (* lotto_select 6 49;; *)
(* 
  let lotto_select n m = 
  let rec aux acc =  *)

(* let lotto_select n m = rand_select (range 1 m) n;; *)
(* Generate a Random Permutation of the Elements of a List *)
(* let permutation ["a"; "b"; "c"; "d"; "e"; "f"];; *)

let permutation list = rand_select list (List.length list);;
permutation ["a"; "b"; "c"; "d"; "e"; "f"];;
(* let permutation list = rand_select list (List.length list) *)


(* Generate the Combinations of K Distinct Objects Chosen From the N Elements of a List *)