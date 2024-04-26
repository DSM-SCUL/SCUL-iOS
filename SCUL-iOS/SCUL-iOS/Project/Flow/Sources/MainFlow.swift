import UIKit
import Swinject
import RxFlow

public final class MainFlow: Flow {
    public let container: Container
    private let rootViewController = BaseNavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainStep else { return .none }
        
        switch step {
        case .mainIsRequired:
            return navigateToMain()
            
        case .placeGuideDetailIsRequired:
            return navigateToPlaceGuideDetail()
        }
    }
}

private extension MainFlow {
    func navigateToMain()-> FlowContributors {
        let mainViewController = container.resolve(MainViewController.self)!

        self.rootViewController.navigationController?.setViewControllers(
            [mainViewController],
            animated: true
        )

        return .one(flowContributor: .contribute(
            withNextPresentable: mainViewController,
            withNextStepper: mainViewController.viewModel
        ))
    }

    func navigateToPlaceGuideDetail() -> FlowContributors {
        let placeGuideDetailFlow = PlaceGuideDetailFlow(container: container)

        Flows.use(placeGuideDetailFlow, when: .created) { root in
            self.rootViewController.pushViewController(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: placeGuideDetailFlow,
            withNextStepper: OneStepper(withSingleStep: PlaceGuideDetailStep.placeGuideDetailIsRequired)
        ))
    }
}
