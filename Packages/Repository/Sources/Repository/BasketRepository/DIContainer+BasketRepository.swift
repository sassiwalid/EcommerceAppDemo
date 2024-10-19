import Foundation

import RxSwift

import DIAbstraction
import BasketAbstraction

extension DIContainer {
    
    public static func registerBasketRepository() {
        
        DIContainer.shared.register(BasketRepositoryProtocol.self) { _ in
            
            let service = DIContainer.shared.resolve(BasketServiceProtocol.self)
            
            return BasketRepository(basketService: service!)
        }
    }
}
