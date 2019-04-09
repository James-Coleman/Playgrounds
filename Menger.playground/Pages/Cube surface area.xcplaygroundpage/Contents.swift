//: [Carpet Surface Area](@previous)

import Foundation
/*
 Surface area of iteration 0 ==
 6 sides of 1 x 1 each ==
 6
 
 Surface area of iteration n ==
 
 
*/

/*:
 For every iteration increase:
 Multiply the number of cubes by 20
 New faces == 20 X 6 == 120
 Every corner cube (total of 8) loses half (3) of its outermost faces == 8 x 3 == 24
 Every edge cube (total of 12) loses one third (2) of its outermost faces == 12 * 2 == 24
 Total 'lost' faces == 48
 Total 'new' faces == 120 - 48 == 72
 
 New faces surface area == ( previous iteration carpet / 9 ) * 72
 Total 'lost' surface area == ( previous iteration carpet / 9 ) * 48
 Total new surface area == ( ( previous iteration surface area / 27 ) * 20 ) - ( ( previous iteration carpet area / 9 ) * 48 )
 
 # Faces split into 9 ( Max iteration 1 )
 
 ## Iteration 0
 6 sides of 9
 6 * 9
 54
 
 ## Iteration 1
 ( 6 sides of 8 ) + ( 6 edges of 2 )
 48 + 12
 60
 
 ## Ratio
 60 / 54
 1.111...
 (one ninth more)
 
 # Faces split into 81 ( Max iteration 2 )
 
 ## Iteration 0
 6 sides of 81
 6 * 81
 486
 
 ## Iteration 1
 Each exteriormost face has 8 groups of 9
 Each new interior face ( 2 per edge ) is 1 group of 9
 ( 6 * ( 8 * 9 ) ) + ( 6 * ( 2 * 9 ) )
 ( 6 * 72 ) + ( 6 * 18 )
 432 + 108
 540
 
 ## Ratio
 540 / 486
 1.111...
 (one ninth more)
 
 ## Iteration 2
 
 
*/

//: [Next](@next)
