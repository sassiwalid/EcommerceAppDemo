import Foundation

import RxSwift

import UserAbstraction

public struct UserRepository: UserRepositoryProtocol {
    
    private var userService: UserServiceProtocol
    
    public init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
    public func addUser(username: String) -> Observable<UserProtocol> {
        
        let user = UserDTO(id: UUID(), userName: username)
        
        return userService
            .addUser(user: user)
            .map {
                UserDTO(
                    id: $0.id,
                    userName: $0.userName
                )
            }
    }
     
}
