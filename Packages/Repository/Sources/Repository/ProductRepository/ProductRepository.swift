import Foundation

import RxSwift

import ProductAbstraction

public struct ProductRepository: ProductRepositoryProtocol {
    
    private var productService: ProductServiceProtocol
    
    public init(productService: ProductServiceProtocol) {
        self.productService = productService
    }
    
    public func fetchAll() -> Observable<[ProductProtocol]> {
        
        productService
            .getProducts()
            .map {
                $0.map {
                    ProductDTO(
                        id: $0.id,
                        name: $0.name,
                        description: $0.description,
                        price: $0.price,
                        category: $0.category,
                        quantity: $0.quantity
                    )
                }
            }
    }
     
}
