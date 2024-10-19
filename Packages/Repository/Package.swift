// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [.iOS(.v15)],
    products: RepositoryProduct.allCases.map(\.product),
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.8.0")),
        .package(path: "../Abstraction")
    ],
    targets: RepositoryProduct.allCases.map(\.target) + RepositoryProduct.allCases.flatMap(\.testsTargets)
)

enum RepositoryProduct: String, CaseIterable {
    
    case BasketRepository
    
    case ProductRepository

    case UserRepository

    // MARK: - Properties

    var path: String { "Sources/Repository/\(rawValue)" }

    var testsPath: String { "Tests/\(rawValue)Tests" }

    var testsName: String { "\(rawValue)Tests" }

    var product: Product { Product.Library.library(product: self) }
    
}

enum ExternalModule: String {
        
    case RxSwift

    var dependency: Target.Dependency {
        
        return switch self {

        case .RxSwift:
            
            .product(
                name: "RxSwift",
                package: "RxSwift"
            )
        }
    }
}

enum AbstractionModule: String {
    
    case BasketAbstraction
    
    case ProductAbstraction

    case UserAbstraction

    case DIAbstraction
    
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
            
        case .DIAbstraction:
            
            .product(
                name: "DIAbstraction",
                package: "Abstraction"
            )
        }
    }
}

extension RepositoryProduct {
    
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
            
        case .BasketRepository:
            [
                .external(.RxSwift),
                .abstraction(.BasketAbstraction),
                .abstraction(.DIAbstraction)
            ]
            
        case .ProductRepository:
            [
                .external(.RxSwift),
                .abstraction(.ProductAbstraction),
                .abstraction(.DIAbstraction)

            ]
            
        case .UserRepository:
            [
                .external(.RxSwift),
                .abstraction(.UserAbstraction),
                .abstraction(.DIAbstraction)

            ]
        }
            
    }
    
    var testsDependencies: [Target.Dependency] {

        switch self {
            
        case .BasketRepository:
            [
                .internal(.BasketRepository)
            ]
            
        case .ProductRepository:
            [
                .internal(.ProductRepository),
            ]
            
        case .UserRepository:
            [
                .internal(.UserRepository),
            ]
        }
    }
}

extension Product.Library {
    
    static func library(product: RepositoryProduct) -> Product {
        .library(
            name: product.rawValue,
            type: nil,
            targets: [product.rawValue]
        )
    }
}

extension Target {
    
    static func target(
        framework: RepositoryProduct,
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
        framework: RepositoryProduct,
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

    static func `internal`(_ product: RepositoryProduct) -> Target.Dependency {

        Target.Dependency(stringLiteral: product.rawValue)
    }
    
    static func external(_ module: ExternalModule) -> Target.Dependency {

        module.dependency
        
    }
    
    static func abstraction(_ module: AbstractionModule) -> Target.Dependency {

        module.dependency
        
    }
}


