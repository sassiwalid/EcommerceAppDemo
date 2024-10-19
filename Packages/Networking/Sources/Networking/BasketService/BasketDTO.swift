import Foundation

import BasketAbstraction

struct BasketDTO: BasketDTOProtocol {
    
    var id: UUID
    
    var productID: UUID
    
    var productName: String
    
    var quantity: Int
    
    var price: Double
    
}
