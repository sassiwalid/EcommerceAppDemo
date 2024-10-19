import Foundation

import DIAbstraction
import UserAbstraction

public extension DIContainer {
    
    static func registerUserService() {
        
        DIContainer.shared.register(UserServiceProtocol.self) { _ in
            
            UserService()
        }
    }
}
