import Foundation
import Combine

import ProductAbstraction
import DIAbstraction

import Utils

final class ProductsListViewModel: ObservableObject {
    
    @Published var products: [ProductProtocol] = []
    
    private let getProductsUseCase: GetProductsUseCaseProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        self.getProductsUseCase = DIContainer.shared.resolve(GetProductsUseCaseProtocol.self)!

        subscribe()
    }
    
    private func subscribe() {
        
        getProductsUseCase.start()
            .asPublisher()
            .receive(on: DispatchQueue.main)
            .assign(to: \.products, on: self)
            .store(in: &cancellables)
        
    }
}
