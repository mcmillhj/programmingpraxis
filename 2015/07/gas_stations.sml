fun findStartingStation stations required_gasoline = let
    val len = length(stations)
    fun loop(current_tank,min_tank,starting_position,current_position,[],required_gasoline) = if current_tank < 0 then ~1
                                                                                              else starting_position
      | loop(current_tank,min_tank,starting_position,current_position,(s::ss),(g::gs)) = let
          val new_tank = current_tank + s - g
      in
          if new_tank < min_tank
          then loop(new_tank,new_tank,(current_position mod len),current_position + 1,ss,gs)
          else loop(new_tank,min_tank,starting_position,current_position + 1,ss,gs)
      end
        
in
    loop(0,1000000,0,1,stations,required_gasoline)
end

val result1 = findStartingStation [15,8,2,6,18,9,21,30] [8,6,30,9,15,21,2,18]
val result2 = findStartingStation [15,8,2,6,18,9,21,29] [8,6,30,9,15,21,2,18]
