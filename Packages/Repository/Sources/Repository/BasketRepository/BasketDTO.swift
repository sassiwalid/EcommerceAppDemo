import Foundation

import BasketAbstraction

public struct BasketDTO: BasketProtocol {
    
    public var id: UUID
    
    public var productID: UUID
    
    public var productName: String
    
    public var quantity: Int
    
    public var price: Double
}
