import UIKit
import Swinject
import RxFlow

public final class OnboardingFlow: Flow {
    public let container: Container
    private let rootViewController = BaseNavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? OnboardingStep else { return .none }

        switch step {
        case .onboardingIsRequired:
            return navigateToOnboarding()

        case .loginIsRequired:
            return navigateToLogin()

        case .signupIsRequired: // 이거는 로그인Flow에만 있어도 될것 같은 부분.
            return navigateToSignup()

        case .tabsIsRequired: // 이건 자동로그인 때문에 필요.
            return .end(forwardToParentFlowWithStep: AppStep.tabsIsRequired)
        }
    }
}

private extension OnboardingFlow {
    func navigateToOnboarding() -> FlowContributors {
        let onboardingViewController = container.resolve(OnboardingViewController.self)!

        self.rootViewController.setViewControllers(
            [onboardingViewController],
            animated: true
        )

        return .one(flowContributor: .contribute(
            withNextPresentable: onboardingViewController,
            withNextStepper: onboardingViewController.viewModel
        ))
    }

    func navigateToLogin() -> FlowContributors {
        let loginFlow = LoginFlow(container: container)

        Flows.use(loginFlow, when: .created) { root in
            self.rootViewController.pushViewController(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: loginFlow,
            withNextStepper: OneStepper(withSingleStep: LoginStep.loginIsRequired)
        ))
    }

    func navigateToSignup() -> FlowContributors {
        let signupFlow = SignupFlow(container: container)

        Flows.use(signupFlow, when: .created) { root in
            self.rootViewController.pushViewController(
                root,
                animated: true
            )
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: signupFlow,
            withNextStepper: OneStepper(withSingleStep: SignupStep.signupIsRequired)
        ))
    }
}
