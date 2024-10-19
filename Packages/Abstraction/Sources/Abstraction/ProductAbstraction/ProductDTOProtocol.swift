import Foundation

public protocol ProductDTOProtocol: Codable {
    
    var id: UUID { get set }
    
    var name: String { get set }
    
    var description: String { get set }
    
    var price: Double { get set }
    
    var category: String { get set }
    
    var quantity: Int { get set }
    
}
