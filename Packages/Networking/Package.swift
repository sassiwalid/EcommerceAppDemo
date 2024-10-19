// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v15)],
    products: NetworkingProduct.allCases.map(\.product),
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.8.0")),
        .package(path: "../Abstraction")
    ],
    targets: NetworkingProduct.allCases.map(\.target) + NetworkingProduct.allCases.flatMap(\.testsTargets)
)

enum NetworkingProduct: String, CaseIterable {
    
    case BasketService
    
    case ProductService

    case UserService
    
    case API

    // MARK: - Properties

    var path: String { "Sources/Networking/\(rawValue)" }

    var testsPath: String { "Tests/\(rawValue)Tests" }

    var testsName: String { "\(rawValue)Tests" }

    var product: Product { Product.Library.library(product: self) }
    
}

enum ExternalModule: String {
        
    case RxSwift
    
    case RxCocoa

    var dependency: Target.Dependency {
        
        return switch self {

        case .RxSwift:
            
            .product(
                name: "RxSwift",
                package: "RxSwift"
            )
            
        case .RxCocoa:
            
                .product(
                    name: "RxCocoa",
                    package: "RxSwift"
                )
        }
    }
}

enum AbstractionModule: String {
    
    case BasketAbstraction
    
    case ProductAbstraction

    case UserAbstraction

    var dependency: Target.Dependency {
        
        return switch self {
        case .BasketAbstraction:
            .product(
                name: "BasketAbstraction",
                package: "Abstraction"
            )
            
        case .ProductAbstraction:
            .product(
                name: "ProductAbstraction",
                package: "Abstraction"
            )
            
        case .UserAbstraction:
            
            .product(
                name: "UserAbstraction",
                package: "Abstraction"
            )
        }
    }
}

extension NetworkingProduct {
    
    var target: Target {
        .target(
            framework: self,
            dependencies: dependencies,
            swiftSettings: [.unsafeFlags(["-enable-testing"])]
        )
    }
    
    var testsTargets: [Target] {
        [
            .testTarget(
                framework: self,
                dependencies: testsDependencies
            )
        ]
    }
    
    var dependencies: [Target.Dependency] {
        return switch self {
            
        case .BasketService:
            [
                .external(.RxSwift),
                .external(.RxCocoa),
                .internal(.API),
                .abstraction(.BasketAbstraction)
            ]
            
        case .ProductService:
            [
                .external(.RxSwift),
                .external(.RxCocoa),
                .internal(.API),
                .abstraction(.ProductAbstraction)
            ]
            
        case .UserService:
            [
                .external(.RxSwift),
                .external(.RxCocoa),
                .internal(.API),
                .abstraction(.UserAbstraction)
            ]
            
        case .API:
            [
                .external(.RxSwift),
                .external(.RxCocoa)
                
            ]
        }
            
    }
    
    var testsDependencies: [Target.Dependency] {

        switch self {
            
        case .BasketService:
            [
                .internal(.BasketService)
            ]
            
        case .ProductService:
            [
                .internal(.ProductService),
            ]
            
        case .UserService:
            [
                .internal(.UserService),
            ]
            
        case .API:
            [
                .internal(.API)
            ]
        }
    }
}

extension Product.Library {
    
    static func library(product: NetworkingProduct) -> Product {
        .library(
            name: product.rawValue,
            type: nil,
            targets: [product.rawValue]
        )
    }
}

extension Target {
    
    static func target(
        framework: NetworkingProduct,
        dependencies: [Target.Dependency] = [],
        exclude: [String] = [],
        sources: [String]? = nil,
        resources: [Resource]? = nil,
        publicHeadersPath: String? = nil,
        cSettings: [CSetting]? = nil,
        cxxSettings: [CXXSetting]? = nil,
        swiftSettings: [SwiftSetting]? = nil,
        linkerSettings: [LinkerSetting]? = nil
    ) -> Target {

        .target(
            name: framework.rawValue,
            dependencies: dependencies,
            path: framework.path,
            exclude: exclude,
            sources: sources,
            resources: resources,
            publicHeadersPath: publicHeadersPath,
            cSettings: cSettings,
            cxxSettings: cxxSettings,
            swiftSettings: swiftSettings,
            linkerSettings: linkerSettings
        )
    }
    
    static func testTarget(
        framework: NetworkingProduct,
        dependencies: [Target.Dependency] = [],
        exclude: [String] = [],
        sources: [String]? = nil,
        resources: [Resource]? = nil,
        cSettings: [CSetting]? = nil,
        cxxSettings: [CXXSetting]? = nil,
        swiftSettings: [SwiftSetting]? = nil,
        linkerSettings: [LinkerSetting]? = nil
    ) -> Target {
        
        .testTarget(
            name: framework.testsName,
            dependencies: dependencies,
            path: framework.testsPath,
            exclude: exclude,
            sources: sources,
            resources: resources,
            cSettings: cSettings,
            cxxSettings: cxxSettings,
            swiftSettings: swiftSettings,
            linkerSettings: linkerSettings
        )
    }
}

extension Target.Dependency {

    static func `internal`(_ product: NetworkingProduct) -> Target.Dependency {

        Target.Dependency(stringLiteral: product.rawValue)
    }
    
    static func external(_ module: ExternalModule) -> Target.Dependency {

        module.dependency
        
    }
    
    static func abstraction(_ module: AbstractionModule) -> Target.Dependency {

        module.dependency
        
    }
}



