import Foundation

import RxSwift

public protocol BasketServiceProtocol {
    
    func addProduct(
        userID: UUID,
        productId: UUID,
        quantity: Int
    ) -> Observable<Void>
    
    func getBasket(userID: UUID) -> Observable<[BasketDTOProtocol]>
}
