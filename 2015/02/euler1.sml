fun sumMultiples3and5LessThanN n =
    let fun gaussian n = (n * (n + 1)) div 2
    in
           3 * gaussian(n div 3)
        +  5 * gaussian(n div 5)
        - 15 * gaussian(n div 15)
    end
