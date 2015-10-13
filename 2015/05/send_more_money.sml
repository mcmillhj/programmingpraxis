val digits = [0,1,2,3,4,5,6,7,8,9]

fun to_num xs =
    List.foldl (fn (a,b) => b * 10 + a) 0 xs
fun remove xs ys =
    List.filter (fn x => not (List.exists (fn y => x = y) xs)) ys;
fun flatten xss =
    List.concat xss
fun print_list xs =
    List.map (fn x => print ((Int.toString x) ^ "\n")) xs
                
fun solve () = let
    val s     = remove [0]                       digits
    val e     = remove (flatten [s])             digits
    val n     = remove (flatten [s, e])          digits
    val d     = remove (flatten [s,e,n])         digits
    (* val send  = to_num (flatten [s,e,n,d]) *)
    (* val m     = remove (flatten [[0],s,e,n,d])   digits *)
    (* val O     = remove (flatten [s,e,n,d,m])     digits *)
    (* val r     = remove (flatten [s,e,n,d,m,O])   digits *)
    (* val more  = to_num (flatten [m,O,r,e]) *)
    (* val y     = remove (flatten [s,e,n,d,m,O,r]) digits *)
    (* val money = to_num (flatten [m,O,n,e,y]) *)
in
    (* print ((Int.toString send) ^ "\n"); *)
    (* print ((Int.toString more) ^ "\n"); *)
    (* print ((Int.toString money) ^ "\n"); *)
    (* send + more = money *)
    List.map print_list [s, e, n, d]
end
