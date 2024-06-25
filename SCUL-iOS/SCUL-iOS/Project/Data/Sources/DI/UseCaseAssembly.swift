import Foundation
import Swinject

public final class UseCaseAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        // Users
        container.register(LoginUseCase.self) { resolver in
            LoginUseCase(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        container.register(SignupUseCase.self) { resolver in
            SignupUseCase(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }
        container.register(FetchMyNameUseCase.self) { resolver in
            FetchMyNameUseCase(
                usersRepository: resolver.resolve(UsersRepository.self)!
            )
        }

        // Cultures
        container.register(FetchCultureListUseCase.self) { resolver in
            FetchCultureListUseCase(
                culturesRepository: resolver.resolve(CulturesRepository.self)!
            )
        }
        container.register(FetchCultureDetailUseCase.self) { resolver in
            FetchCultureDetailUseCase(
                culturesRepository: resolver.resolve(CulturesRepository.self)!
            )
        }
        container.register(SearchCultureUseCase.self) { resolver in
            SearchCultureUseCase(
                culturesRepository: resolver.resolve(CulturesRepository.self)!
            )
        }

        // Reviews
        container.register(FetchMyReviewListUseCase.self) { resolver in
            FetchMyReviewListUseCase(
                reviewsRepository: resolver.resolve(ReviewsRepository.self)!
            )
        }
        container.register(FetchReviewListUseCase.self) { resolver in
            FetchReviewListUseCase(
                reviewsRepository: resolver.resolve(ReviewsRepository.self)!
            )
        }

        // Bookmarks
        container.register(FetchBookmarkListUseCase.self) { resolver in
            FetchBookmarkListUseCase(
                bookmarksRepository: resolver.resolve(BookmarksRepository.self)!
            )
        }
        container.register(BookmarkUseCase.self) { resolver in
            BookmarkUseCase(
                bookmarksRepository: resolver.resolve(BookmarksRepository.self)!
            )
        }
    }
}
