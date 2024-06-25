import UIKit
import Swinject
import RxFlow

public final class BookmarkFlow: Flow {
    public let container: Container
    private let rootViewController: BookmarkViewController
    public var root: Presentable {
        return rootViewController
    }

    public init(container: Container) {
        self.container = container
        self.rootViewController = container.resolve(BookmarkViewController.self)!
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
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }
    
    func navigateToPlaceGuideDetail() -> FlowContributors {
        let placeGuideDetailFlow = PlaceGuideDetailFlow(container: container)
        
        Flows.use(placeGuideDetailFlow, when: .created) { root in
            self.rootViewController.navigationController?.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: placeGuideDetailFlow,
            withNextStepper: OneStepper(withSingleStep: PlaceGuideDetailStep.placeGuideDetailIsRequired)
        ))
    }
}
