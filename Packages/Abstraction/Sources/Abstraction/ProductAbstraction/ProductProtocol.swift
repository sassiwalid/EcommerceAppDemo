import Foundation

public protocol ProductProtocol {
    
    var id: UUID { get }
    
    var name: String { get }
    
    var description: String { get }
    
    var price: Double { get }
    
    var category: String { get }
    
    var quantity: Int { get }
}
