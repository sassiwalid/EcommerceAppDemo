import Foundation

import ProductAbstraction

public struct ProductDTO: ProductProtocol {
    
    public let id: UUID
    
    public let name: String
    
    public let description: String
    
    public let price: Double
    
    public let category: String
    
    public let quantity: Int
}
