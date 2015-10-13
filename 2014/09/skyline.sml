(* The Skyline Puzzle is a classic programming exercise; 
   it draws a silhouette of a city skyline by blocking out portions of buildings that are masked by taller buildings. 
   A city is a list of buildings specified as triples containing left edge, height, and right edge. 
   For instance, the list of triples 
      (1 11 5) (2 6 7) (3 13 9) (12 7 16) (14 3 25) (19 18 22) (23 13 29) (24 4 28) encodes the eight buildings shown at the left of the diagram, 
   and the path 
      1 11 3 13 9 0 12 7 16 3 19 18 22 3 23 13 29 0 encodes the skyline shown at the right of the diagram, 
   where the odd-indexed elements of the output are the x-coordinate of the skyline and the even-indexed elements of the output are the y-coordinate of the skyline. 
   (It makes more sense to me that the output should look like (1 11) (3 13) (9 0) (12 7) (16 3) (19 18) (22 3) (23 13) (29 0) but that’s not the way the puzzle is ever specified.) 
   
   Notice that the second (2 6 7) and eighth (24 4 28) buildings are not part of the skyline.  
*)

val buildings = [
    (1, 11, 5),   (2, 6, 7), 
    (3, 13, 9),   (12, 7, 16), 
    (14, 3, 25),  (19, 18, 22), 
    (23, 13, 29), (24, 4, 28)
];

(* splits a list into two semi-equal halves in Linear time *)
fun split ns = let 
    fun loop([], xs, ys) = (xs, ys)
      | loop(x::y::zs, xs, ys) = loop(zs, x::xs, y::ys)
      | loop(x::[], xs, ys) = loop([], x::xs, ys)
in
    loop(List.rev(ns), [], [])
end

(* function that compares two triples by their first element *)
fun lessthan_building ((a,_,_),(b,_,_)) = a < b;

(* function that takes a position and generates a function that compares
  tripples by the element at that position *)
fun mk_lessthan 1 = (fn ((a,_,_),(b,_,_)) => a < b)
  | mk_lessthan 2 = (fn ((_,a,_),(_,b,_)) => a < b)
  | mk_lessthan 3 = (fn ((_,_,a),(_,_,b)) => a < b)
  | mk_lessthan _ = raise Domain;

(* Merge two ordered lists using the order lt.
 * Pre: the given lists xs and ys must already be ordered per lt.
 * Runs in O(n) time, where n = |xs| + |ys|. *)
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

fun max [] = 0
  | max (x::xs) = foldl Int.max x xs;

fun scan s [] = []
  | scan s ((m,h)::xs) = let
      val s' = if h < 0 then List.filter(fn x => x <> ~h) s else h::s
  in
      (m, (max s')) :: (scan s' xs)
  end;
 
fun skyline [] = [] 
  | skyline xs = mergesort (op <) xs; 

fun expand [] = []
  | expand ((a,b,c)::xs) = (a,b)::(c,~b)::expand(xs); 

fun filt [] = []
  | filt [(s,h)] = [(s,h)] 
  | filt((s,h)::(s',h')::xs) =
    if s = s' then filt ((s',h')::xs) 
    else if h = h' then filt((s, h)::xs)
    else (s,h) :: filt((s',h')::xs);
