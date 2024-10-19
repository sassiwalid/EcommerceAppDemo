import Foundation

import DIAbstraction
import ProductAbstraction

extension DIContainer {
    
    public static func registerProductService() {
        
        DIContainer.shared.register(ProductServiceProtocol.self) { _ in
            
            ProductService()
        }
    }
}
