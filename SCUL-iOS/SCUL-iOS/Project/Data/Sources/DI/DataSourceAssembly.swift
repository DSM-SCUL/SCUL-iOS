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

        container.register(RemoteCulturesDataSource.self) { resolver in
            RemoteCulturesDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteBookmarksDataSource.self) { resolver in
            RemoteBookmarksDataSourceImpl(keychain: self.keychain(resolver))
        }

        container.register(RemoteReviewsDataSource.self) { resolver in
            RemoteReviewsDataSourceImpl(keychain: self.keychain(resolver))
        }
    }
}
