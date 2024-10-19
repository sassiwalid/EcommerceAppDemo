import Foundation

import RxSwift

public protocol UserServiceProtocol {
    
    func addUser(user: UserProtocol) -> Observable<UserDTOProtocol>
}
