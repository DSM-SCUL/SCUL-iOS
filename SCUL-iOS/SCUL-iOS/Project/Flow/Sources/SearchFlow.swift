import UIKit
import Swinject
import RxFlow

public final class SearchFlow: Flow {
    public let container: Container
    private let rootViewController = BaseNavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SearchStep else { return .none }
        
        switch step {
        case .searchIsRequired:
            return navigateToSearch()

        case let .placeGuideDetailIsRequired(id):
            return navigateToPlaceGuideDetail(cultureDetailId: id)
        }
    }
}

private extension SearchFlow {
    func navigateToSearch()-> FlowContributors {
        let searchViewController = container.resolve(SearchViewController.self)!

        self.rootViewController.setViewControllers(
            [searchViewController],
            animated: true
        )

        return .one(flowContributor: .contribute(
            withNextPresentable: searchViewController,
            withNextStepper: searchViewController.viewModel
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
            withNextStepper: OneStepper(withSingleStep: PlaceGuideDetailStep.placeGuideDetailIsRequired)
        ))
    }
}
