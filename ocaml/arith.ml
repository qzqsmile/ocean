(* 31. Determine whether a given integer number is prime. (medium) *)
  
let is_prime n =
  let n = abs n in
  let rec is_not_divisor d =
    d * d > n || (n mod d <> 0 && is_not_divisor (d + 1)) in
  n <> 1 && is_not_divisor 2;;

  not (is_prime 1);;

  is_prime 7;;

  (* 32. Determine the greatest common divisor of two positive integer numbers. (medium) *)

let rec gcd a b =
  if b = 0 then a else gcd b (a mod b);;

gcd 1 2

(* 35. Determine the prime factors of a given positive integer. (medium) *)
let factors n =
  let rec aux d n =
    if n = 1 then [] else
      if n mod d = 0 then d :: aux d (n / d) else aux (d + 1) n
  in
    aux 2 n;

factors 315;;
