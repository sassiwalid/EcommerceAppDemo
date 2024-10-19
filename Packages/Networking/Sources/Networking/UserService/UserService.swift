import Foundation

import RxSwift

import UserAbstraction
import API
 
struct UserService: UserServiceProtocol {

    private let apiProvider: APIProviderProtocol
    
    init() {
        self.apiProvider = APIProvider()
    }

    func addUser(user: UserProtocol) -> Observable<UserDTOProtocol> {
        
        let userRequestBody = UserDTO(
            id: user.id,
            userName: user.userName
        )
        
        return apiProvider.perform(
            
            UserServiceAPI.addUser(user: userRequestBody)
        )
        .map(UserDTO.self)
        .map { $0 as UserDTOProtocol }
    }
}

