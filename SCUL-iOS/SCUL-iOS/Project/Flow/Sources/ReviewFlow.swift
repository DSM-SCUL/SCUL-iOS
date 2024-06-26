import UIKit
import Swinject
import RxFlow

public final class ReviewFlow: Flow {
    public let container: Container
    private let rootViewController: ReviewViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = container.resolve(ReviewViewController.self)!
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? ReviewStep else { return .none }
        
        switch step { // pop할 때 detail 뷰 써야하는데 이것도 포함 시켜야하나?
        case .reviewIsRequired:
            return navigateToReview()
        }
    }
}

private extension ReviewFlow {
    func navigateToReview()-> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
//        let reviewViewController = container.resolve(ReviewViewController.self)!
//
//        self.rootViewController.navigationController?.setViewControllers(
//            [reviewViewController],
//            animated: true
//        )
//
//        return .one(flowContributor: .contribute(
//            withNextPresentable: reviewViewController,
//            withNextStepper: reviewViewController.viewModel
//        ))
    }
}
