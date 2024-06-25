import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

class OnboardingViewController: BaseViewController<OnboardingViewModel> {
    private let navigateToLoginButtonDidTap = PublishRelay<Void>()

    private let logoImageView = UIImageView().then {
        $0.image = UIImage.SculLogo
    }
    private let navigateToLoginButton = UIButton().then {
        $0.backgroundColor = .Main500.withAlphaComponent(0.7)
        $0.setTitle("로그인 후 SCUL 사용하기", for: .normal)
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont.button2
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
    }

    public override func addView() {
        [
            logoImageView,
            navigateToLoginButton
        ].forEach { self.view.addSubview($0) }
    }

    public override func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        navigateToLoginButton.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(262)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(72)
        }
    }

    public override func bind() {
        let input = OnboardingViewModel.Input(
            navigateToLoginButtonDidTap: navigateToLoginButtonDidTap
        )

        let _ = viewModel.transform(input)
    }

    public override func configureViewController() {
        navigateToLoginButton.rx.tap
            .subscribe(onNext: { _ in
                self.navigateToLoginButtonDidTap.accept(())
            })
            .disposed(by: disposeBag)
    }

    public override func configureNavigation() {}
}
