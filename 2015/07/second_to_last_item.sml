fun next_to_last_item [] = ~1 (* return -1 on error *)
  | next_to_last_item (x::y::nil) = x
  | next_to_last_item (x::xs) = next_to_last_item xs
                                                  
val test_valid_list = (next_to_last_item [1, 2, 3, 4, 5]) = 4
val test_empty_list = (next_to_last_item []) = ~1
val test_single_elem_list = (next_to_last_item [1]) = ~1

fun nth_from_last_item n [] = ~1
  | nth_from_last_item n lst = let
      val len = List.length lst
      fun loop counter [] = ~1 (* counter goes past end of list *)
        | loop counter (x::xs) = if len - counter = n then x
                                 else loop (counter + 1) xs
  in

      loop 0 lst
  end

val test_1st_from_last = (nth_from_last_item 1 [1, 2, 3, 4, 5]) = 5
val test_2nd_from_last = (nth_from_last_item 2 [1, 2, 3, 4, 5]) = 4

(* rewriting next_to_last_item using nth_from_last_item *)
fun next_to_last_item2 xs = nth_from_last_item 2 xs;
val test_valid_list2 = (next_to_last_item2 [1, 2, 3, 4, 5]) = 4
val test_empty_list2 = (next_to_last_item2 []) = ~1
val test_single_elem_list2 = (next_to_last_item2 [1]) = ~1

val all_test_pass =
    List.all (fn x => x) [test_valid_list, test_empty_list, test_single_elem_list, test_1st_from_last, test_2nd_from_last, test_valid_list2, test_empty_list2, test_single_elem_list2];
