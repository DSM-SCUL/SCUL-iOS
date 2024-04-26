import UIKit
import Swinject
import RxFlow

public final class MyReviewFlow: Flow {
    public let container: Container
    private let rootViewController = BaseNavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MyReviewStep else { return .none }
        
        switch step {
        case .myReviewIsRequired:
            return navigateToMyReview()
        }
    }
}

private extension MyReviewFlow {
    func navigateToMyReview()-> FlowContributors {
        let myReviewViewController = container.resolve(MyReviewViewController.self)!

        self.rootViewController.navigationController?.setViewControllers(
            [myReviewViewController],
            animated: true
        )

        return .one(flowContributor: .contribute(
            withNextPresentable: myReviewViewController,
            withNextStepper: myReviewViewController.viewModel
        ))
    }
}
