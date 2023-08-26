let is_prime n =
  let n = abs n in
  let rec is_not_divisor d =
    d * d > n || (n mod d <> 0 && is_not_divisor (d + 1)) in
  n <> 1 && is_not_divisor 2;;


  let rec gcd a b =
      if b = 0 then a else gcd b (a mod b);;
  gcd 13 27;;
  
  let coprime a b = gcd a b = 1;;
  
  coprime 13 27;;

  