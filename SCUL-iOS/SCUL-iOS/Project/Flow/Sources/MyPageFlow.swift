import UIKit
import Swinject
import RxFlow

public final class MyPageFlow: Flow {
    public let container: Container
    private let rootViewController = BaseNavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MyPageStep else { return .none }
        
        switch step {
        case .myPageIsRequired:
            return navigateToMyPage()

        case .myReviewIsRequired:
            return navigateToMyReview()

        case .bookmarkIsRequired:
            return navigateToBookmark()

        case .tabsIsRequired:
            return .end(forwardToParentFlowWithStep: TabsStep.appIsRequired)
        }
    }
}

private extension MyPageFlow {
    func navigateToMyPage()-> FlowContributors {
        let myPageViewController = container.resolve(MyPageViewController.self)!

        self.rootViewController.setViewControllers(
            [myPageViewController],
            animated: true
        )

        return .one(flowContributor: .contribute(
            withNextPresentable: myPageViewController,
            withNextStepper: myPageViewController.viewModel
        ))
    }

    func navigateToMyReview() -> FlowContributors {
        let myReviewFlow = MyReviewFlow(container: container)

        Flows.use(myReviewFlow, when: .created) { root in
            self.rootViewController.pushViewController(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: myReviewFlow,
            withNextStepper: OneStepper(withSingleStep: MyReviewStep.myReviewIsRequired)
        ))
    }

    func navigateToBookmark() -> FlowContributors {
        let bookmarkFlow = BookmarkFlow(container: container)

        Flows.use(bookmarkFlow, when: .created) { root in
            self.rootViewController.pushViewController(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: bookmarkFlow,
            withNextStepper: OneStepper(withSingleStep: BookmarkStep.bookmarkIsRequired)
        ))
    }
}
