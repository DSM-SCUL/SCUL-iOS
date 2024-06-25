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

        container.register(CulturesRepository.self) { resolver in
            CulturesRepositoryImpl(
                remoteCulturesDataSource: resolver.resolve(RemoteCulturesDataSource.self)!
            )
        }

        container.register(BookmarksRepository.self) { resolver in
            BookmarksRepositoryImpl(
                remoteBookmarksDataSource: resolver.resolve(RemoteBookmarksDataSource.self)!
            )
        }

        container.register(ReviewsRepository.self) { resolver in
            ReviewsRepositoryImpl(
                remoteReviewsDataSource: resolver.resolve(RemoteReviewsDataSource.self)!
            )
        }
    }
}
