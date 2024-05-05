import UIKit
import Swinject
import RxFlow

public final class SignupFlow: Flow {
    public let container: Container
    private let rootViewController: SignupViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = SignupViewController(container.resolve(SignupViewModel.self)!)
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SignupStep else { return .none }

        switch step {
        case .signupIsRequired:
            return navigateToSignup()

        case .loginIsRequired:
            return navigateToLogin()

        case .tabsIsRequired:
            return .end(forwardToParentFlowWithStep: SignupStep.tabsIsRequired)
        }
    }
}

private extension SignupFlow {
    func navigateToLogin() -> FlowContributors {
        let loginFlow = LoginFlow(container: container)

        Flows.use(loginFlow, when: .created) { root in
            self.rootViewController.navigationController?.pushViewController(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: loginFlow,
            withNextStepper: OneStepper(withSingleStep: LoginStep.loginIsRequired)
        ))
    }

    func navigateToSignup() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }
}
