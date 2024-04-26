import UIKit
import Swinject
import RxFlow

public class AppFlow: Flow {

    private var window: UIWindow
    public let container: Container

    public var root: RxFlow.Presentable {
        return window
    }

    public init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
    }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? AppStep else { return .none }

        switch step {
        case .onboardingIsRequired:
            return navigateToOnboarding()

        case .tabsIsRequired:
            return .end(forwardToParentFlowWithStep: AppStep.tabsIsRequired)
        }
    }

    private func navigateToOnboarding() -> FlowContributors {
        let onboardingFlow = OnboardingFlow(container: container)
        Flows.use(onboardingFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: onboardingFlow,
            withNextStepper: OneStepper(withSingleStep: OnboardingStep.onboardingIsRequired)
        ))
    }
}
