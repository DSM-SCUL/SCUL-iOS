import Foundation
import Swinject

public final class PresentationAssembly: Assembly {
    public init() {}
//    001bb07f-7af0-43af-a93e-3e3c49946385
    public func assemble(container: Container) {
        container.register(OnboardingViewController.self) { resolver in
            OnboardingViewController(resolver.resolve(OnboardingViewModel.self)!)
        }
        container.register(OnboardingViewModel.self) { resolver in
            OnboardingViewModel()
        }

        container.register(LoginViewController.self) { resolver in
            LoginViewController(resolver.resolve(LoginViewModel.self)!)
        }
        container.register(LoginViewModel.self) { resolver in
            LoginViewModel(loginUseCase: resolver.resolve(LoginUseCase.self)!)
        }

        container.register(SignupViewController.self) { resolver in
            SignupViewController(resolver.resolve(SignupViewModel.self)!)
        }
        container.register(SignupViewModel.self) { resolver in
            SignupViewModel(signupUseCase: resolver.resolve(SignupUseCase.self)!)
        }

        container.register(MainViewController.self) { resolver in
            MainViewController(resolver.resolve(MainViewModel.self)!)
        }
        container.register(MainViewModel.self) { resolver in
            MainViewModel(
                fetchCultureListUseCase: resolver.resolve(FetchCultureListUseCase.self)!,
                bookmarkUseCase: resolver.resolve(BookmarkUseCase.self)!
            )
        }

        container.register(SearchViewController.self) { resolver in
            SearchViewController(resolver.resolve(SearchViewModel.self)!)
        }
        container.register(SearchViewModel.self) { resolver in
            SearchViewModel(
                fetchCultureListUseCase: resolver.resolve(FetchCultureListUseCase.self)!,
                bookmarkUseCase: resolver.resolve(BookmarkUseCase.self)!,
                searchCulture: resolver.resolve(SearchCultureUseCase.self)!
            )
        }

        container.register(MyPageViewController.self) { resolver in
            MyPageViewController(resolver.resolve(MyPageViewModel.self)!)
        }
        container.register(MyPageViewModel.self) { resolver in
            MyPageViewModel(fetchMyNameUseCase: resolver.resolve(FetchMyNameUseCase.self)!)
        }

        container.register(PlaceGuideDetailViewController.self) { resolver in
            PlaceGuideDetailViewController(resolver.resolve(PlaceGuideDetailViewModel.self)!)
        }
        container.register(PlaceGuideDetailViewModel.self) { resolver in
            PlaceGuideDetailViewModel(
                fetchCultureDetailUseCase: resolver.resolve(FetchCultureDetailUseCase.self)!,
                fetchReviewListUseCase: resolver.resolve(FetchReviewListUseCase.self)!,
                bookmarkUseCase: resolver.resolve(BookmarkUseCase.self)!
            )
        }

        container.register(MyReviewViewController.self) { resolver in
            MyReviewViewController(resolver.resolve(MyReviewViewModel.self)!)
        }
        container.register(MyReviewViewModel.self) { resolver in
            MyReviewViewModel(fetchMyReviewListUseCase: resolver.resolve(FetchMyReviewListUseCase.self)!)
        }

        container.register(BookmarkViewController.self) { resolver in
            BookmarkViewController(resolver.resolve(BookmarkViewModel.self)!)
        }
        container.register(BookmarkViewModel.self) { resolver in
            BookmarkViewModel(
                fetchBookmarkListUseCase: resolver.resolve(FetchBookmarkListUseCase.self)!,
                bookmarkUseCase: resolver.resolve(BookmarkUseCase.self)!
            )
        }

        container.register(ReviewViewController.self) { resolver in
            ReviewViewController(resolver.resolve(ReviewViewModel.self)!)
        }
        container.register(ReviewViewModel.self) { resolver in
            ReviewViewModel()
        }
    }
}
