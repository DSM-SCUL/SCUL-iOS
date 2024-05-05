import UIKit
import Swinject
import RxFlow

public final class PlaceGuideDetailFlow: Flow {
    public let container: Container
    private let rootViewController: PlaceGuideDetailViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = container.resolve(PlaceGuideDetailViewController.self)!
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? PlaceGuideDetailStep else { return .none }
        
        switch step {
        case .placeGuideDetailIsRequired:
            return navigateToPlaceGuideDetail()
            
        case .reviewIsRequired:
            return navigateToReview()
        }
    }
}

private extension PlaceGuideDetailFlow {
    func navigateToPlaceGuideDetail()-> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }

    func navigateToReview() -> FlowContributors {
        let reviewFlow = ReviewFlow(container: container)

        Flows.use(reviewFlow, when: .created) { root in
            self.rootViewController.navigationController?.pushViewController(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: reviewFlow,
            withNextStepper: OneStepper(withSingleStep: ReviewStep.reviewIsRequired)
        ))
    }
}
