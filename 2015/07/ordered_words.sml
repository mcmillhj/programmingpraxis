fun readFile infile = let
    val ins = TextIO.openIn infile
    fun loop ins =
        case TextIO.inputLine ins of
            SOME line => (List.filter
                              (fn c => (ord c) <> 10) (explode line)) :: loop ins
         |  NONE      => []
in
    loop ins before TextIO.closeIn ins
end

fun mergesort lt xs = let
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
    fun split ns = let
        fun loop([], xs, ys) = (xs, ys)
          | loop(x::y::zs, xs, ys) = loop(zs, x::xs, y::ys)
          | loop(x::[], xs, ys) = loop([], x::xs, ys)
    in
        loop(List.rev(ns), [], [])
    end
                       
    val merge' = merge lt
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
                          
val dict = readFile("/usr/share/dict/words")
fun longestOrderedWord (dict : char list list) = let
    val alphasort = mergesort (Char.<)
    fun isAlphabetical [] = false
      | isAlphabetical xs = (implode (alphasort xs)) = (implode xs)
    fun firstTwoCharsOrdered [] = false
      | firstTwoCharsOrdered (x::[]) = true
      | firstTwoCharsOrdered (x::y::xs) = Char.<= (x, y)
    fun loop [] longest = longest
      | loop (x::xs) longest = let
          val word = (implode x)
      in
          if firstTwoCharsOrdered(x)
             andalso isAlphabetical(x)
             andalso (size word) > (size longest)
          then (loop xs word)
          else (loop xs longest)
      end

in
    loop dict ""
end

(* compute longest word *)
val longest = longestOrderedWord dict
val () = TextIO.print longest
                                 
