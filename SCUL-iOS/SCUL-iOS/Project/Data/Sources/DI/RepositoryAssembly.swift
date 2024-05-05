import Foundation
import Swinject

public final class RepositoryAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.register(UsersRepository.self) { resolver in
            UsersRepositoryImpl(
                remoteUsersDataSource: resolver.resolve(RemoteUsersDataSource.self)!
            )
        }
    }
}
