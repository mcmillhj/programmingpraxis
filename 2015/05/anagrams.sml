fun merge lt (xs, ys) = let
    fun loop(out, [], []) = List.rev out
      | loop(out, x::xs, []) = loop (x::out, xs, [])
      | loop(out, [], y::ys) = loop (y::out, [], ys)
      | loop(out, left as x::xs, right as y::ys) =
                if lt (x, y) then loop (x::out, xs, right)
                else loop (y::out, left, ys)
in
    loop([], xs, ys)
end

fun mergesort lt xs = let
    val merge' = merge lt
    (* splits a list into two semi-equal halves in Linear time *)
    fun split ns = let 
        fun loop([], xs, ys) = (xs, ys)
          | loop(x::y::zs, xs, ys) = loop(zs, x::xs, y::ys)
          | loop(x::[], xs, ys) = loop([], x::xs, ys)
    in
        loop(List.rev(ns), [], [])
    end      
    fun ms []  = []
      | ms [x] = [x]
      | ms xs = let
          val (l, r) = split xs
      in
          merge'(ms l, ms r)
      end
in
    ms xs
end

fun anagram1 a b = if a = b then true else let
    val a_list = explode a
    val b_list = explode b
    val ms     = mergesort (op <) 
in
    (ms a_list) = (ms b_list)
end

fun anagram2 a b = let
    val array = Array.tabulate(128, fn _ => 0)
in
    CharVector.app (fn char => Array.update (array, ord char, Array.sub (array, ord char) + 1)) a;
    CharVector.app (fn char => Array.update (array, ord char, Array.sub (array, ord char) - 1)) b;
    Array.all (fn e => e = 0) array
end
