import Foundation

public protocol UserDTOProtocol: Codable {
    
    var id: UUID { get set }
    
    var userName: String { get set }
}
