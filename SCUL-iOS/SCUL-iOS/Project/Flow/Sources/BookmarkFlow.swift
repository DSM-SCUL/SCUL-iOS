import UIKit
import Swinject
import RxFlow

public final class BookmarkFlow: Flow {
    public let container: Container
    private let rootViewController = BaseNavigationController()
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? BookmarkStep else { return .none }
        
        switch step {
        case .bookmarkIsRequired:
            return navigateToBookmark()

        case .placeGuideDetailIsRequired:
            return navigateToPlaceGuideDetail()
        }
    }
}

private extension BookmarkFlow {
    func navigateToBookmark()-> FlowContributors {
        let bookmarkViewController = container.resolve(BookmarkViewController.self)!
        
        self.rootViewController.navigationController?.setViewControllers(
            [bookmarkViewController],
            animated: true
        )
        
        return .one(flowContributor: .contribute(
            withNextPresentable: bookmarkViewController,
            withNextStepper: bookmarkViewController.viewModel
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
