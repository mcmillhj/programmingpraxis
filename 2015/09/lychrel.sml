fun reverse_number n = let
    val reversed_n =
        case Int.fromString (implode (List.rev (explode (Int.toString n)))) of
            SOME rn => rn
          | NONE => raise Domain 
in
    reversed_n
end

fun lychrel n = (reverse_number n) + n
