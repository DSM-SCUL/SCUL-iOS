import UIKit
import Swinject
import RxFlow

public final class MyReviewFlow: Flow {
    public let container: Container
    private let rootViewController: MyReviewViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = container.resolve(MyReviewViewController.self)!
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
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }
}
