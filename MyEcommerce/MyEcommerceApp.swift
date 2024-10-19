import SwiftUI

import ProductsFeature
import LoginFeature
import BasketFeature

import UserDomain
import UserRepository
import UserService

import ProductDomain
import ProductRepository
import ProductService

import BasketDomain
import BasketRepository
import BasketService

import DIAbstraction

enum Screen {
    case Products
    
    case Basket
}

final class TabRouter: ObservableObject {
    
    @Published var screen: Screen = .Products
    
    func change(to screen: Screen) {
        self.screen = screen
    }
}

@main
struct MyEcommerceApp: App {
    
    @StateObject private var tabRouter = TabRouter()
    
    @StateObject private var loginViewModel = LoginViewModel()
            
    init() {
                
        DIContainer.registerUserService()
        DIContainer.registerUserRepository()
        DIContainer.registerLoginUserUseCase()
        
        DIContainer.registerProductService()
        DIContainer.registerProductRepository()
        DIContainer.registerGetProductsUseCase()
        
        DIContainer.registerBasketService()
        DIContainer.registerBasketRepository()
        DIContainer.registerAddProductUseCase()
        DIContainer.registerGetBasketUseCase()
    }
    
    var body: some Scene {
        WindowGroup {
            
            LoginView(loginViewModel: loginViewModel)
                .fullScreenCover(isPresented: $loginViewModel.isConnected) {
                    
                    if let userId = loginViewModel.userID {
                        
                        TabView(selection: $tabRouter.screen) {
                            
                            ProductListView(userId: userId)
                                .tag(Screen.Products)
                                .environmentObject(tabRouter)
                                .tabItem {
                                    Label("Products", systemImage: "drop.halffull")
                                }
                            
                            BasketView(userId: userId)
                                .tag(Screen.Basket)
                                .tabItem {
                                    Label("Basket", systemImage: "cart.fill")
                                }
                        }
                        
                         
                        
                    } else {
                        
                        Text("Connexion Error")
                    }
                }
        }
    }
}

