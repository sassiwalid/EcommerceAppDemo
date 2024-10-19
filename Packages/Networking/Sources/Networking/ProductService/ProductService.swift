import Foundation

import RxSwift

import API
import ProductAbstraction
 
struct ProductService: ProductServiceProtocol {
    
    private let apiProvider: APIProviderProtocol
    
    init() {
        self.apiProvider = APIProvider()
    }

    public func getProducts() -> Observable<[ProductDTOProtocol]> {
        
        apiProvider
            .perform(ProductAPI.getProducts)
            .map([ProductDTO].self)
            .map { $0 as [ProductDTOProtocol] }
    }
}

