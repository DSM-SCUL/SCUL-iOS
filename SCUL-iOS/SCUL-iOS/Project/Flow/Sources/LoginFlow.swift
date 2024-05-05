import UIKit
import Swinject
import RxFlow

public final class LoginFlow: Flow {
    public let container: Container
    private let rootViewController: LoginViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = LoginViewController(container.resolve(LoginViewModel.self)!) //
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? LoginStep else { return .none }

        switch step {
        case .loginIsRequired:
            return navigateToLogin()

        case .signupIsRequired:
            return navigateToSignup()

        case .tabsIsRequired:
            return .end(forwardToParentFlowWithStep: OnboardingStep.tabsIsRequired)
        }
    }
}

private extension LoginFlow {
    func navigateToLogin() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }

    func navigateToSignup() -> FlowContributors {
        let signupFlow = SignupFlow(container: container)

        Flows.use(signupFlow, when: .created) { root in
            self.rootViewController.navigationController?.pushViewController(
                root,
                animated: true
            )
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: signupFlow,
            withNextStepper: OneStepper(
                withSingleStep: SignupStep.signupIsRequired
            )
        ))
    }
}
