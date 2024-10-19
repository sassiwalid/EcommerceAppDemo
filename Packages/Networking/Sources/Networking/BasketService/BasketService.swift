import Foundation

import RxSwift

import BasketAbstraction
import API
 
struct BasketService: BasketServiceProtocol {
    
    private let apiProvider: APIProviderProtocol
    
    init() {
        self.apiProvider = APIProvider()
    }

    public func addProduct(
        userID: UUID,
        productId: UUID,
        quantity: Int
    ) -> Observable<Void> {
        
        apiProvider
            .perform(
                BasketAPI.addProduct(
                    userID: userID,
                    productId: productId,
                    quantity: quantity
                )
            )
            .map { _ in () }
    }
    
    func getBasket(userID: UUID) -> Observable<[BasketDTOProtocol]> {
        
        apiProvider
            .perform(BasketAPI.getBasket(userID: userID))
            .map([BasketDTO].self)
            .map { $0 as [BasketDTOProtocol] }
    }
}

