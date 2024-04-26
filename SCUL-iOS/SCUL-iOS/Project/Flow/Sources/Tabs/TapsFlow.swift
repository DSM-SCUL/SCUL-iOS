import UIKit
import RxFlow
import Swinject

public final class TabsFlow: Flow {
    public let container: Container
    private let rootViewController = BaseTabBarController()
    public var root: Presentable {
        return rootViewController
    }

    init(container: Container) {
        self.container = container
    }

    public func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? TabsStep else { return .none }

        switch step {
        case .tabsIsRequired:
            return navigateToTabs()

        case .appIsRequired:
            return dismissToOnbording()
        }
    }
}

private extension TabsFlow {
    private func navigateToTabs() -> FlowContributors {
        let mainFlow = MainFlow(container: container)
        let searchFlow = SearchFlow(container: container)
        let myPageFlow = MyPageFlow(container: container)

        Flows.use(
            mainFlow,
            searchFlow,
            myPageFlow,
            when: .created
        ) { [weak self] main, search, mypage in
            main.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
            search.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
            mypage.tabBarItem = UITabBarItem(title: "MY", image: UIImage(systemName: "face.smiling.inverse"), tag: 2)

            self?.rootViewController.setViewControllers(
                [
                    main,
                    search,
                    mypage
                ],
                animated: false
            )
        }

        return .multiple(flowContributors: [
            .contribute(
                withNextPresentable: mainFlow,
                withNextStepper: OneStepper(withSingleStep: MainStep.mainIsRequired)
            ),
            .contribute(
                withNextPresentable: searchFlow,
                withNextStepper: OneStepper(withSingleStep: SearchStep.searchIsRequired)
            ),
            .contribute(
                withNextPresentable: myPageFlow,
                withNextStepper: OneStepper(withSingleStep: MyPageStep.myPageIsRequired)
            )
        ])
    }

    private func dismissToOnbording() -> FlowContributors {
        UIView.transition(
            with: self.rootViewController.view.window!,
            duration: 0.5,
            options: .transitionCrossDissolve) {
                self.rootViewController.dismiss(animated: false)
            }

        return .end(forwardToParentFlowWithStep: AppStep.onboardingIsRequired)
    }
}
