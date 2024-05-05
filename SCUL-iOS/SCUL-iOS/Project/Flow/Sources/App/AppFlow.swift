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
            return navigationToTabs()
        }
    }
}

private extension AppFlow {
    func navigateToOnboarding() -> FlowContributors {
        let onboardingFlow = OnboardingFlow(container: container)

        Flows.use(onboardingFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: onboardingFlow,
            withNextStepper: OneStepper(withSingleStep: OnboardingStep.onboardingIsRequired)
        ))
    }
    
    func navigationToTabs() -> FlowContributors {
        let tabsFlow = TabsFlow(container: container)

        Flows.use(tabsFlow, when: .created) { (root) in
            UIView.transition(
                with: self.window,
                duration: 0.5,
                options: .transitionCrossDissolve
            ) {
                self.window.rootViewController = root
            }
        }

        return .one(
            flowContributor: .contribute(
                withNextPresentable: tabsFlow,
                withNextStepper: OneStepper(withSingleStep: TabsStep.tabsIsRequired)
            )
        )
    }
}
