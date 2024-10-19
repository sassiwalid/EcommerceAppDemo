import Foundation

import BasketAbstraction
import DIAbstraction

extension DIContainer {
    
    public static func registerBasketService() {
        
        DIContainer.shared.register(BasketServiceProtocol.self) { _ in
            
            BasketService()
        }
    }
}
