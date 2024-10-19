import Foundation

import RxSwift

import DIAbstraction
import UserAbstraction

extension DIContainer {
    
    public static func registerUserRepository() {
        
        DIContainer.shared.register(UserRepositoryProtocol.self) { _ in
            
            let service = DIContainer.shared.resolve(UserServiceProtocol.self)
            
            return UserRepository(userService: service!)
        }
    }
}
