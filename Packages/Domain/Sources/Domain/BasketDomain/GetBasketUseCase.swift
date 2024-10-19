import Foundation

import BasketAbstraction

import RxSwift

public struct GetBasketUseCase: GetBasketUseCaseProtocol {
    
    let basketRepository: BasketRepositoryProtocol
    
    public init(basketRepository: BasketRepositoryProtocol) {
        self.basketRepository = basketRepository
    }
    
    public func start(userID: UUID) -> Observable<[BasketProtocol]> {
        
        basketRepository.fetchBasket(userID: userID)
    }
}


