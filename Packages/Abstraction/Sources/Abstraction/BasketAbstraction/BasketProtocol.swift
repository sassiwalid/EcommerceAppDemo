import Foundation

public protocol BasketProtocol {
    
    var id: UUID { get }
    
    var productID: UUID { get }
    
    var productName: String { get }
    
    var quantity: Int { get }
    
    var price: Double { get }
    
}
