import Foundation

public protocol BasketDTOProtocol: Codable {
    
    var id: UUID { get }
    
    var productID: UUID { get }
    
    var productName: String { get }
    
    var quantity: Int { get }
    
    var price: Double { get }
    
}
