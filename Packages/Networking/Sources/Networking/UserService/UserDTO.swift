import Foundation

import UserAbstraction

struct UserDTO: UserDTOProtocol {
    
    var id: UUID = UUID()
    
    var userName: String
    
}
