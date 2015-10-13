fun intersect (xs, ys) = let
    fun loop(out, _, [])      = List.rev out
      | loop(out, [], _)      = List.rev out
      | loop(out,left as x::xs, right as y::ys) =
           if x < y then loop(out, xs, right)
           else if y < x then loop(out, left, ys)
           else loop(x::out, xs, ys)
in
    loop([], xs, ys)
end

fun nintersect []  = []
  | nintersect (xs::xss) = List.foldl intersect xs xss;
