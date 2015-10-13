(* tail recursive solution that counts upwards from 1 
   O(N) - only touches each odd number up to N
*)
fun sumFirstNOdds n = let
    fun loop curr count acc =
        if count = n then acc
        else case (curr mod 2)
              of 1  => loop (curr + 2) (count + 1) (acc + curr) 
               | _  => loop (curr + 1) count acc
in
    loop 1 0 0
end

(* closed form formula SUM( odd(x) | x >= 1 and x <= N ) = N^2 *)
fun sumFirstNOdds2 n = n * n;

