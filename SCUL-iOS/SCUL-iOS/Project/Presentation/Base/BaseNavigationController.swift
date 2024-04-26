import UIKit

public class BaseNavigationController: UINavigationController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearance()
    }

    static func makeNavigationController(
        rootViewController: UIViewController
    ) -> BaseNavigationController {
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = .fullScreen
        return navigationController
    }

    private var backButtonImage: UIImage? {
        return UIImage(systemName: "chevron.left")!
            .withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: -12.0, bottom: 0.0, right: 0.0))
    }

    private var backButtonAppearance: UIBarButtonItemAppearance {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        return backButtonAppearance
    }

    private func setNavigationBarAppearance() {
        let scrollEdgeAppearance = UINavigationBarAppearance()
        let standardAppearance = UINavigationBarAppearance()
        navigationBar.tintColor = .Gray900
        scrollEdgeAppearance.setBackIndicatorImage(
            backButtonImage,
            transitionMaskImage: backButtonImage
        )
        standardAppearance.setBackIndicatorImage(
            backButtonImage,
            transitionMaskImage: backButtonImage
        )
        scrollEdgeAppearance.backgroundColor = .white

        scrollEdgeAppearance.configureWithTransparentBackground()
        standardAppearance.configureWithDefaultBackground()
        scrollEdgeAppearance.backButtonAppearance = backButtonAppearance
        standardAppearance.backButtonAppearance = backButtonAppearance
        scrollEdgeAppearance.largeTitleTextAttributes = [
            .font: UIFont.sb1,
            .foregroundColor: UIColor.black
        ]
        navigationBar.standardAppearance = standardAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        self.navigationController?.navigationBar.backItem?.title = nil
    }
}
