import Foundation
import Swinject

public final class DataSourceAssembly: Assembly {
    public init() {}

    private let keychain = { (resolver: Resolver) in
        resolver.resolve(Keychain.self)!
    }

    public func assemble(container: Container) {
        container.register(RemoteUsersDataSource.self) { resolver in
            RemoteUsersDataSourceImpl(keychain: self.keychain(resolver))
        }
//
//        container.register(RemoteUsersDataSource.self) { resolver in
//            RemoteUsersDataSourceImpl(keychain: self.keychain(resolver))
//        }
    }
}
