import Foundation

import RxSwift

public protocol ProductServiceProtocol {
    
    func getProducts() -> Observable<[ProductDTOProtocol]>
}
