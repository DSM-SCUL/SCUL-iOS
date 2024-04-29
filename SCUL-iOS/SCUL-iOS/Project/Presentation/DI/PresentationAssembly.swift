import Foundation
import Swinject

public final class PresentationAssembly: Assembly {
    public init() {}

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
            LoginViewModel()
        }

        container.register(SignupViewController.self) { resolver in
            SignupViewController(resolver.resolve(SignupViewModel.self)!)
        }
        container.register(SignupViewModel.self) { resolver in
            SignupViewModel()
        }

        container.register(MainViewController.self) { resolver in
            MainViewController(resolver.resolve(MainViewModel.self)!)
        }
        container.register(MainViewModel.self) { resolver in
            MainViewModel()
        }

        container.register(SearchViewController.self) { resolver in
            SearchViewController(resolver.resolve(SearchViewModel.self)!)
        }
        container.register(SearchViewModel.self) { resolver in
            SearchViewModel()
        }

        container.register(MyPageViewController.self) { resolver in
            MyPageViewController(resolver.resolve(MyPageViewModel.self)!)
        }
        container.register(MyPageViewModel.self) { resolver in
            MyPageViewModel()
        }
    }
}
