import Foundation

import RxSwift

import DIAbstraction
import ProductAbstraction

extension DIContainer {
    
    public static func registerProductRepository() {
        
        DIContainer.shared.register(ProductRepositoryProtocol.self) { _ in
            
            let service = DIContainer.shared.resolve(ProductServiceProtocol.self)
            
            return ProductRepository(productService: service!)
        }
    }
}
