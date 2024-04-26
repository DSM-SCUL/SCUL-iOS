import UIKit
import SnapKit
import Then

class OnboardingViewController: BaseViewController<OnboardingViewModel> {
    private let logoImageView = UIImageView().then {
        $0.image = UIImage.SculLogo
    }
    private let navigateToLoginButton = UIButton().then {
        $0.setTitle("로그인 후 SCUL 사용하기", for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    public override func addView() {}

    public override func setLayout() {}

    public override func bind() {}

    public override func configureViewController() {}

    public override func configureNavigation() {}
}
