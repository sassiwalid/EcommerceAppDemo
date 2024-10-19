import Foundation
import Combine

import ProductAbstraction
import BasketAbstraction
import DIAbstraction

final class ItemDetailViewModel: ObservableObject {
    
    @Published var product: ProductProtocol
    
    @Published var quantity: Int = 1
    
    private let addProductUseCase: AddProductUseCaseProtocol
    
    private let userId: UUID
    
    private var cancellables = Set<AnyCancellable>()

    init(
        product: ProductProtocol,
        userId: UUID
    ) {
        
        self.product = product
        
        self.userId = userId
        
        addProductUseCase = DIContainer.shared.resolve(AddProductUseCaseProtocol.self)!

    }
    
    func addProduct() {
        
        addProductUseCase.start(
            userID: userId,
            productId: product.id,
            quantity: quantity
        )
        .asPublisher()
        .sink(receiveValue: {})
        .store(in: &cancellables)
    }
    
}
