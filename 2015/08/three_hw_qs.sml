fun sumSquaresOfTwoLargest (a,b,c) = let
    fun square n = n * n 
    fun reduce (x,y) = (square x) + (square y)
    open Int
in
    reduce(max(a, max(b,c)), min(max(a,b), max(a,c)))
end

fun integerIsPalindrome n = let
    fun intToDigits 0 ds = ds
      | intToDigits n ds = intToDigits (n div 10) ((n mod 10) :: ds)
    fun isPalindrome xs ds = let
in
    isPalindrome (intToDigits n []) []
end

(* count the number of factors of 5 exist inside of N
this will tell us in turn how many factors of this number are 10 which implies added 0s *)
fun numberTrailingZerosFromFactorialOfN n = let
    fun numberFactorsXOfN count starting_factor factor =
        if (n div factor) <= 0 then count
        else numberFactorsXOfN (count + (n div factor)) starting_factor (factor*starting_factor)
in
    numberFactorsXOfN 0 5 5
end
