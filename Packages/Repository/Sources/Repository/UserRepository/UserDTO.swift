import Foundation

import UserAbstraction

public struct UserDTO: UserProtocol {
    
    public let id: UUID
    
    public let userName: String
    
}
