(* Determine Whether a Given Integer Number Is Prime Intermediate *)
let is_prime n =
  let n = abs n in
  let rec is_not_divisor d =
    d * d > n || (n mod d <> 0 && is_not_divisor (d + 1)) in
  n > 1 && is_not_divisor 2;;


(* Determine the Greatest Common Divisor of Two Positive Integer Numbers Intermediate *)
  let rec gcd a b =
      if b = 0 then a else gcd b (a mod b);;
  gcd 13 27;;
  
  let coprime a b = gcd a b = 1;;
  
(* Calculate Euler's Totient Function Φ(m) Intermediate *)
(* coprime 13 27;; *)
let phi num = 
    let rec aux c count =
      if num = 1 then 1
      else if num = c then count 
      else if (coprime num  c) then aux (c+1) (count+1)
      else aux (c+1) count in 
      aux 1 0;;


(* Determine the Prime Factors of a Given Positive Integer *)
(* factors 315;; *)
let factors1 num = 
  let rec aux c acc num = 
    if 1 = num then [1]
    else if c = num then num::acc 
    else if num mod c <> 0 then aux (c+1) acc num
    else aux 2 (c::acc) (num/c)
  in List.rev (aux 2 [] num);;

let factors num = 
  let rec aux cur count acc = function 
  | [] -> (cur,count)::acc 
  | h::t -> 
    if h = cur then aux cur (count+1) acc t 
    else if count <> 0 then aux h 1 ((cur, count)::acc) t 
    else aux h 1 acc t 
  in List.rev (aux 0 0 [] (factors1 num));;


  (* Calculate Euler's Totient Function Φ(m) (Improved)？? *)


  (* Compare the Two Methods of Calculating Euler's Totient Function *)



  (* A List of Prime Numbers *)
  (* List.length (all_primes 2 7920);; *)
let all_primes b e = 
  let rec aux cur acc =
    if cur > e then acc 
    else if is_prime cur then aux (cur+1) (cur::acc)
    else aux (cur+1) acc
  in List.rev (aux b []);;

  (* Goldbach's Conjecture *)

  (* goldbach 28;; *)

let goldbach num = 
  let rec aux c1 c2 = 
    if is_prime c1 && is_prime c2 then (c1, c2)
    else aux (c1+1) (c2-1) in 
    aux 1 (num-1);;



    (* A List of Goldbach Compositions *)

    (* goldbach_list 9 20;; *)

  let goldbach_list b e = 
    let rec aux cur acc = 
      if cur > e then acc else 
      if cur mod 2 = 0 then aux (cur+2) ((cur, goldbach(cur))::acc)
      else aux (cur+1) acc in 
      List.rev (aux b []);;
      
  

  (* type 'b rle =
  | One of 'b
  | Many of int * 'b;; *)