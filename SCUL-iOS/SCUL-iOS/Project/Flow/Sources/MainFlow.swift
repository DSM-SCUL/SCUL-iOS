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
            
        case let .placeGuideDetailIsRequired(id):
            return navigateToPlaceGuideDetail(cultureDetailId: id)
        }
    }
}

private extension MainFlow {
    func navigateToMain()-> FlowContributors {
        let mainViewController = container.resolve(MainViewController.self)!

        self.rootViewController.setViewControllers(
            [mainViewController],
            animated: true
        )

        return .one(flowContributor: .contribute(
            withNextPresentable: mainViewController,
            withNextStepper: mainViewController.viewModel
        ))
    }

    func navigateToPlaceGuideDetail(cultureDetailId: String) -> FlowContributors {
        let placeGuideDetailFlow = PlaceGuideDetailFlow(container: container)
        Flows.use(placeGuideDetailFlow, when: .created) { (root) in
            let view = root as? PlaceGuideDetailViewController
            view?.viewModel.cultureDetailId = cultureDetailId
            self.rootViewController.pushViewController(
                view!,
                animated: true
            )
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: placeGuideDetailFlow,
            withNextStepper: OneStepper(
                withSingleStep: PlaceGuideDetailStep.placeGuideDetailIsRequired
            )
        ))
    }
}
