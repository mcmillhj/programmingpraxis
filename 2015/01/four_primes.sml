fun isPrime n =
    if n < 2 then false              
    else if n mod 2 = 0 then n = 2   
    else
        let fun noDivisorsAbove m  =   
                if n mod m = 0 then false
                else if m*m >= n then true
                else noDivisorsAbove(m + 1)
        in
            noDivisorsAbove 2
        end

fun goldbach n =
    let fun loop(i, j) =
            if isPrime(i) andalso isPrime(j) then [i, j]
            else loop(i+1, j-1)
    in
        loop(2, n-2)
    end
                  
fun fourPrimes n =
    if n < 8 then raise Domain
    else if n mod 2 = 0 then 2 :: 2 :: goldbach(n-4)
    else 2 :: 3 :: goldbach(n-5)
        
