fun inflection_point [] = raise Domain
  | inflection_point (R as x::xs) = let
      val sum = foldl (op +) 0 R
      fun inflection_point_aux [] difference current_index diff_index prev_sum sum = (difference, diff_index)
        | inflection_point_aux (x::xs) difference current_index diff_index prev_sum sum = let
            val left = x + prev_sum
            val right = sum - x
            val new_difference = Int.abs(left-right)
        in
            if new_difference < difference then inflection_point_aux xs new_difference (current_index + 1) current_index left right
            else inflection_point_aux xs difference (current_index + 1) diff_index left right
        end
  in
      inflection_point_aux R sum 0 0 0 sum
  end
